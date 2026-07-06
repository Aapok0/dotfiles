#!/usr/bin/env bash
# Validate Brewfile syntax and that entries resolve in Homebrew.
# Unlike `brew bundle check`, does not require packages to be installed.
#
# Usage: tests/run brewfile   (host; needs brew on PATH)
#        bash tests/brewfile-smoke.sh [Brewfile]
set -euo pipefail

BREWFILE=${1:-Brewfile}

echo "Parsing $BREWFILE..."
formulae=$(brew bundle list --file="$BREWFILE")
casks=$(brew bundle list --cask --file="$BREWFILE" 2>/dev/null || true)
printf '  %s formulae, %s casks\n' "$(printf '%s\n' "$formulae" | sed '/^$/d' | wc -l)" \
    "$(printf '%s\n' "$casks" | sed '/^$/d' | wc -l)"

while IFS= read -r line; do
    [[ "$line" =~ ^tap\ \"([^\"]+)\" ]] || continue
    tap="${BASH_REMATCH[1]}"
    echo "Tapping $tap..."
    if ! tap_out=$(brew tap "$tap" 2>&1); then
        if grep -qiE 'deprecated|empty' <<<"$tap_out"; then
            echo "  ⊘ $tap (deprecated, skipping)"
            continue
        fi
        echo "$tap_out" >&2
        exit 1
    fi
done <"$BREWFILE"

echo "Verifying formulae..."
while IFS= read -r formula; do
    [[ -n "$formula" ]] || continue
    brew info "$formula" >/dev/null
done <<<"$formulae"

echo "Verifying casks..."
while IFS= read -r cask; do
    [[ -n "$cask" ]] || continue
    if brew info --cask "$cask" >/dev/null 2>&1; then
        echo "  ✓ $cask"
        continue
    fi
    # macOS-only casks may not resolve on Linux, but should still exist upstream.
    if [[ "$(uname -s)" != "Darwin" ]] \
        && brew search --cask --online "^${cask}$" 2>/dev/null | grep -qFx "$cask"; then
        echo "  ⊘ $cask (defined upstream, macOS-only install)"
        continue
    fi
    echo "cask not found: $cask" >&2
    exit 1
done <<<"$casks"

echo "Brewfile OK"
