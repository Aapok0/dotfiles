#!/usr/bin/env bash
# Shared install/update helpers for the dotfiles justfile recipes.
#
# Sourced (not executed) from recipe shebang blocks, which run from the repo
# root:  source scripts/justlib.sh
#
# The point is update-on-bump: recipes used to install only `if ! have <tool>`,
# so a Renovate version bump never reinstalled. Here every pinned tool records
# its installed version/ref in a marker file and is reinstalled when the marker
# no longer matches the pinned value (covers upgrade and downgrade alike).

_dotfiles_state_dir() {
    printf '%s/dotfiles/versions' "${XDG_STATE_HOME:-$HOME/.local/state}"
}

marker_get() {
    cat "$(_dotfiles_state_dir)/$1" 2>/dev/null || true
}

marker_set() {
    local dir
    dir=$(_dotfiles_state_dir)
    mkdir -p "$dir"
    printf '%s\n' "$2" >"$dir/$1"
}

bin_needs_update() {
    local name=$1 bin=$2 version=$3
    command -v "$bin" &>/dev/null || return 0
    [ "$(marker_get "$name")" != "$version" ]
}

# Download <url> to <dest> and verify its SHA256.
dl_verify() {
    local url=$1 dest=$2 sha=$3
    curl -fsSL -o "$dest" "$url"
    echo "$sha  $dest" | sha256sum -c - >/dev/null
}

# Echo the SHA256 from an upstream "<url>.sha256" sidecar file.
gh_sha_sidecar() {
    curl -fsSL "$1.sha256" | awk '{print $1}'
}

# Echo the SHA256 for <asset> from an upstream checksums file (default
# checksums.txt) of the "<sha>  <name>" form.
gh_sha_checksums() {
    local base=$1 asset=$2 file=${3:-checksums.txt}
    curl -fsSL "$base/$file" | awk -v a="$asset" '$2 == a {print $1}'
}

_install_to() {
    local src=$1 dest=$2 dir
    dir=$(dirname "$dest")
    mkdir -p "$dir" 2>/dev/null || true
    if [ -w "$dir" ]; then
        install -m 755 "$src" "$dest"
    else
        sudo install -m 755 "$src" "$dest"
    fi
}

# Install a pinned release artifact, marker-guarded.
#   install_release <name> <version> <dest> <url> <sha> <kind> [members]
#     dest    canonical path of the primary binary (its dir is the install dir,
#             its basename is the binary checked for the up-to-date short-circuit)
#     kind    raw | tar | gz | zip | deb
#     members space-separated names to extract+install (tar/zip); defaults to the
#             dest basename. Use e.g. "yazi ya" to install several from one fetch.
install_release() {
    local name=$1 version=$2 dest=$3 url=$4 sha=$5 kind=$6 members=${7:-}
    local bin dir tmp m
    bin=$(basename "$dest")
    dir=$(dirname "$dest")
    members=${members:-$bin}

    if ! bin_needs_update "$name" "$bin" "$version"; then
        echo "  ✓ $name $version (up to date)"
        return 0
    fi

    echo "  → installing $name $version"
    tmp=$(mktemp -d)
    # shellcheck disable=SC2064  # expand $tmp now so the trap removes this dir
    trap "rm -rf '$tmp'" RETURN

    case "$kind" in
        raw)
            dl_verify "$url" "$tmp/$bin" "$sha"
            _install_to "$tmp/$bin" "$dest"
            ;;
        gz)
            dl_verify "$url" "$tmp/a.gz" "$sha"
            gunzip -f "$tmp/a.gz"
            _install_to "$tmp/a" "$dest"
            ;;
        tar)
            dl_verify "$url" "$tmp/a.tar.gz" "$sha"
            tar xf "$tmp/a.tar.gz" -C "$tmp"
            for m in $members; do
                _install_to "$(find "$tmp" -type f -name "$m" | head -1)" "$dir/$m"
            done
            ;;
        zip)
            dl_verify "$url" "$tmp/a.zip" "$sha"
            unzip -q "$tmp/a.zip" -d "$tmp/x"
            for m in $members; do
                _install_to "$(find "$tmp/x" -type f -name "$m" | head -1)" "$dir/$m"
            done
            ;;
        deb)
            dl_verify "$url" "$tmp/a.deb" "$sha"
            sudo dpkg -i "$tmp/a.deb" || sudo apt-get install -f -y
            ;;
        *)
            echo "  ⚠ install_release: unknown kind '$kind'" >&2
            return 1
            ;;
    esac

    marker_set "$name" "$version"
}

# Clone <repo> into <dir> (if absent) and check out the pinned <ref> (tag or
# commit), marker-guarded so a bump re-syncs.
git_sync() {
    local name=$1 dir=$2 repo=$3 ref=$4

    if [ -d "$dir/.git" ] && [ "$(marker_get "$name")" = "$ref" ]; then
        echo "  ✓ $name $ref (up to date)"
        return 0
    fi

    if [ -d "$dir/.git" ]; then
        echo "  → updating $name to $ref"
        git -C "$dir" fetch --tags --force origin
    else
        echo "  → cloning $name"
        git clone "$repo" "$dir"
    fi

    git -C "$dir" checkout --detach "$ref"
    marker_set "$name" "$ref"
}
