#!/usr/bin/env bash
# In-container smoke test for `just lint-tools`. Runs as root inside a distro
# image (see tests/run.sh). Installs build prerequisites, copies the repo to a
# writable tree, runs lint-tools, then verifies expected binaries exist.
#
# Usage (inside container):  bash /repo/tests/lint-tools-smoke.sh <arch|debian|fedora>
set -euo pipefail

REPO=${REPO:-/repo}
distro=${1:?usage: lint-tools-smoke.sh <arch|debian|fedora>}

export HOME=/root
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:/usr/local/bin:$PATH"
export XDG_STATE_HOME="$HOME/.local/state"

install_prereqs() {
    case "$1" in
        debian)
            export DEBIAN_FRONTEND=noninteractive
            apt-get update
            apt-get install -y --no-install-recommends \
                sudo just git curl ca-certificates unzip \
                build-essential cargo nodejs npm \
                python3 python3-pip python3-venv pipx \
                lua5.4 liblua5.4-dev luarocks
            ;;
        fedora)
            dnf install -y \
                sudo just git curl unzip \
                gcc make cargo nodejs npm \
                python3 pipx \
                lua lua-devel luarocks
            ;;
        arch)
            pacman-key --init
            pacman-key --populate archlinux
            pacman -Sy --noconfirm archlinux-keyring
            pacman -Syu --noconfirm
            pacman -S --needed --noconfirm \
                sudo just git curl unzip \
                base-devel rust nodejs npm \
                python python-pipx
            ;;
        *)
            echo "unknown distro: $1" >&2
            exit 2
            ;;
    esac
}

verify_tools() {
    local missing=() cmd
    for cmd in \
        shellcheck shfmt ruff ty hadolint tflint taplo gitleaks \
        ansible-lint stylua prettier luacheck; do
        if ! command -v "$cmd" &>/dev/null; then
            missing+=("$cmd")
        else
            printf '  ✓ %s: ' "$cmd"
            "$cmd" --version 2>/dev/null | head -1 || true
        fi
    done
    if ((${#missing[@]} > 0)); then
        echo "SMOKE FAIL ($distro): missing: ${missing[*]}"
        exit 1
    fi
}

echo "########## lint-tools smoke / $distro ##########"
install_prereqs "$distro"

rm -rf /work
cp -a "$REPO" /work
cd /work

echo "--- just lint-tools ---"
just lint-tools

echo "--- verify installed tools ---"
verify_tools

echo "SMOKE OK ($distro): lint-tools completed, all expected binaries on PATH"
