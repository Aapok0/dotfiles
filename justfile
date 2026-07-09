# Dotfiles management
# Usage: just <recipe>
# List recipes: just --list

# Default recipe — show available commands
default:
    @just --list

# Default terminal emulator (kitty, wezterm, or ghostty)
terminal := "ghostty"

# Core configs to stow (always included)
core_dirs := "agents bat gitconfig nvim skills starship tmux tmux-tools vim zsh lazygit yazi atuin"

# ──── Pinned tool versions (kept current by Renovate; see renovate.json) ──────
# Renovate bumps the version line on each release. delta/zoxide/yazi/nerd-fonts/taplo
# pin a literal SHA256 that Renovate CANNOT refresh — its PR is left un-automerged;
# regenerate the hash with:  curl -fsSL <download-url> | sha256sum
# The other tools verify against an upstream checksums file, so no local hash.
# Pinned release binaries are x86_64/amd64 (ruff/ty/hadolint/tflint also do aarch64).

# renovate: datasource=github-releases depName=dandavison/delta
delta_version := "0.19.2"
delta_sha256 := "ea4f0222950ee750a3d38dd80d03bce4cee07a3f63928fc47548383bcaf23093"

# renovate: datasource=github-releases depName=ajeetdsouza/zoxide
zoxide_version := "0.10.0"
zoxide_sha256 := "4ff057d3c4d957946937274c2b8be7af2a9bbae7f90a1b5e9baaa7cb65a20caa"

# renovate: datasource=github-releases depName=sxyazi/yazi
yazi_version := "26.5.6"
yazi_sha256 := "1c9096f0a83b8102c194385f644cdeff93cc8269426163c9d033041ebd537bd2"

# renovate: datasource=github-releases depName=starship/starship
starship_version := "1.26.0"

# renovate: datasource=github-releases depName=atuinsh/atuin
atuin_version := "18.16.1"

# renovate: datasource=github-releases depName=jesseduffield/lazygit
lazygit_version := "0.63.0"

# renovate: datasource=github-releases depName=warrensbox/terraform-switcher
tfswitch_version := "1.19.0"

# renovate: datasource=github-releases depName=getsops/sops
sops_version := "3.13.2"

# renovate: datasource=github-releases depName=JohnnyMorganz/StyLua
stylua_version := "2.5.2"

# renovate: datasource=npm depName=prettier
prettier_version := "3.9.4"

# renovate: datasource=github-releases depName=astral-sh/ruff
ruff_version := "0.15.20"

# renovate: datasource=github-releases depName=astral-sh/ty
ty_version := "0.0.56"

# renovate: datasource=github-releases depName=hadolint/hadolint
hadolint_version := "2.14.0"

# renovate: datasource=github-releases depName=terraform-linters/tflint
tflint_version := "0.63.1"

# renovate: datasource=github-releases depName=tamasfe/taplo
taplo_version := "0.10.0"
taplo_sha256 := "8fe196b894ccf9072f98d4e1013a180306e17d244830b03986ee5e8eabeb6156"

# renovate: datasource=github-releases depName=gitleaks/gitleaks
gitleaks_version := "8.30.1"

# renovate: datasource=github-releases depName=ryanoasis/nerd-fonts
nerdfonts_version := "3.4.0"
nerdfonts_jetbrainsmono_sha256 := "ef552a3e638f25125c6ad4c51176a6adcdce295ab1d2ffacf0db060caf8c1582"

# ──── Pinned git dependencies (zsh plugins, tmux/fzf tooling) ─────────────────
# Cloned + checked out at the ref below; a Renovate bump re-syncs (see git_sync
# in scripts/justlib.sh). Tagged where upstream tags releases; fzf-git.sh has no
# tags, so it is pinned to a commit (datasource=git-refs).

# renovate: datasource=github-tags depName=tmux-plugins/tpm
tpm_version := "v3.1.0"

# renovate: datasource=github-tags depName=zdharma-continuum/fast-syntax-highlighting
fast_syntax_highlighting_version := "v1.56"

# renovate: datasource=github-tags depName=zsh-users/zsh-autosuggestions
zsh_autosuggestions_version := "v0.7.1"

# renovate: datasource=github-tags depName=zsh-users/zsh-completions
zsh_completions_version := "0.36.0"

# renovate: datasource=git-refs depName=junegunn/fzf-git.sh
fzf_git_sh_commit := "d76cd4df21f2ca5aafeab8b31118c4df133472c0"

# ---------------------------------------------------------------------------
# Stow
# ---------------------------------------------------------------------------

# Stow/unstow/restow all dotfiles (uses default terminal, override with: just terminal=ghostty stow-all)
stow-all:
    @echo "Stowing all configs (terminal: {{terminal}})..."
    @for dir in {{terminal}} {{core_dirs}}; do \
        if [ -d "$dir" ]; then \
            echo "  → $dir"; \
            if [ "$dir" = "atuin" ] && [ ! -L "$HOME/.config/atuin" ] && [ -f "$HOME/.config/atuin/config.toml" ] && [ ! -L "$HOME/.config/atuin/config.toml" ]; then \
                echo "  → replacing installer atuin config with dotfiles version"; \
                rm -f "$HOME/.config/atuin/config.toml"; \
            fi; \
            stow -v --target="$HOME" "$dir" 2>&1 | grep -v "^$" || true; \
        fi; \
    done
    @echo "Done."

unstow-all:
    @echo "Unstowing all configs (terminal: {{terminal}})..."
    @for dir in {{terminal}} {{core_dirs}}; do \
        if [ -d "$dir" ]; then \
            echo "  → $dir"; \
            stow -v -D --target="$HOME" "$dir" 2>&1 | grep -v "^$" || true; \
        fi; \
    done
    @echo "Done."

restow-all:
    @echo "Restowing all configs (terminal: {{terminal}})..."
    @for dir in {{terminal}} {{core_dirs}}; do \
        if [ -d "$dir" ]; then \
            echo "  → $dir"; \
            if [ "$dir" = "atuin" ] && [ ! -L "$HOME/.config/atuin" ] && [ -f "$HOME/.config/atuin/config.toml" ] && [ ! -L "$HOME/.config/atuin/config.toml" ]; then \
                echo "  → replacing installer atuin config with dotfiles version"; \
                rm -f "$HOME/.config/atuin/config.toml"; \
            fi; \
            stow -v -R --target="$HOME" "$dir" 2>&1 | grep -v "^$" || true; \
        fi; \
    done
    @echo "Done."

stow name:
    #!/usr/bin/env bash
    if [[ "{{name}}" == "atuin" ]]; then
        target="$HOME/.config/atuin/config.toml"
        if [[ ! -L "$HOME/.config/atuin" && -f "$target" && ! -L "$target" ]]; then
            echo "  → replacing installer atuin config with dotfiles version"
            rm -f "$target"
        fi
    fi
    stow -v --target="$HOME" "{{name}}"

unstow name:
    stow -v -D --target="$HOME" {{name}}

# ---------------------------------------------------------------------------
# macOS Setup
# ---------------------------------------------------------------------------

brew-install:
    brew bundle --file=Brewfile

# Check what's missing from Brewfile
brew-check:
    brew bundle check --file=Brewfile --verbose

# ---------------------------------------------------------------------------
# Linux Setup
# ---------------------------------------------------------------------------

# Install core dependencies
# Debian (packages not in default repos are installed via alternative methods)
apt-install:
    #!/usr/bin/env bash
    set -euo pipefail
    source scripts/justlib.sh
    sudo apt-get update
    sudo apt-get install -y \
        neovim tmux zsh git stow curl cargo \
        build-essential cmake nodejs npm python3 \
        ripgrep fzf fd-find bat \
        direnv thefuck tldr \
        btop entr xclip wl-clipboard jq age \
        ffmpeg p7zip-full poppler-utils imagemagick \
        ansible kubectl helm \
        ibus ibus-gtk4 ibus-gtk3

    if ! command -v eza &>/dev/null; then
        if [[ ! -f /etc/apt/sources.list.d/gierens.list ]]; then
            sudo mkdir -p /etc/apt/keyrings
            wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
            echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
        fi
        sudo apt-get update && sudo apt-get install -y eza
    fi

    if bin_needs_update delta delta "{{delta_version}}"; then
        arch="$(dpkg --print-architecture)"
        if [[ "$arch" != "amd64" ]]; then
            echo "Pinned git-delta is amd64-only (got $arch); install manually: https://github.com/dandavison/delta/releases"
            exit 1
        fi
    fi
    install_release delta "{{delta_version}}" /usr/local/bin/delta \
        "https://github.com/dandavison/delta/releases/download/{{delta_version}}/git-delta_{{delta_version}}_amd64.deb" \
        "{{delta_sha256}}" deb

    install_release zoxide "{{zoxide_version}}" "$HOME/.local/bin/zoxide" \
        "https://github.com/ajeetdsouza/zoxide/releases/download/v{{zoxide_version}}/zoxide-{{zoxide_version}}-x86_64-unknown-linux-musl.tar.gz" \
        "{{zoxide_sha256}}" tar

    if bin_needs_update starship starship "{{starship_version}}"; then
        url="https://github.com/starship/starship/releases/download/v{{starship_version}}/starship-x86_64-unknown-linux-gnu.tar.gz"
        install_release starship "{{starship_version}}" "$HOME/.local/bin/starship" \
            "$url" "$(gh_sha_sidecar "$url")" tar
    fi

    if bin_needs_update atuin atuin "{{atuin_version}}"; then
        url="https://github.com/atuinsh/atuin/releases/download/v{{atuin_version}}/atuin-x86_64-unknown-linux-gnu.tar.gz"
        install_release atuin "{{atuin_version}}" "$HOME/.local/bin/atuin" \
            "$url" "$(gh_sha_sidecar "$url")" tar
    fi

    if bin_needs_update lazygit lazygit "{{lazygit_version}}"; then
        asset="lazygit_{{lazygit_version}}_linux_x86_64.tar.gz"
        base="https://github.com/jesseduffield/lazygit/releases/download/v{{lazygit_version}}"
        install_release lazygit "{{lazygit_version}}" /usr/local/bin/lazygit \
            "$base/$asset" "$(gh_sha_checksums "$base" "$asset")" tar
    fi

    install_release yazi "{{yazi_version}}" "$HOME/.local/bin/yazi" \
        "https://github.com/sxyazi/yazi/releases/download/v{{yazi_version}}/yazi-x86_64-unknown-linux-gnu.zip" \
        "{{yazi_sha256}}" zip "yazi ya"

    if ! command -v gh &>/dev/null; then
        if [[ ! -f /etc/apt/sources.list.d/github-cli.list ]]; then
            sudo mkdir -p /etc/apt/keyrings
            curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null
            echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list
        fi
        sudo apt-get update && sudo apt-get install -y gh
    fi

    if ! command -v dust &>/dev/null; then
        cargo install du-dust 2>/dev/null || echo "Install dust: cargo install du-dust (requires cargo)"
    fi
    if ! command -v procs &>/dev/null; then
        cargo install procs 2>/dev/null || echo "Install procs: cargo install procs (requires cargo)"
    fi

    just sops-install
    just lint-tools

# Arch (official repos)
pacman-install:
    sudo pacman -S --needed \
        neovim tmux zsh git git-delta stow curl \
        base-devel cmake nodejs npm python rust \
        ripgrep fzf fd bat eza zoxide starship dust procs \
        atuin direnv thefuck tldr \
        lazygit yazi btop entr xclip wl-clipboard jq github-cli age sops \
        ffmpeg p7zip poppler imagemagick \
        ansible kubectl helm \
        ibus
    just lint-tools

# Fedora — one package per dnf install (already-installed RPMs must not be batched)
dnf-install:
    #!/usr/bin/env bash
    set -euo pipefail
    source scripts/justlib.sh

    dnf_install() {
        local pkg=$1
        if rpm -q "$pkg" &>/dev/null; then
            echo "  ✓ $pkg (already installed)"
            return 0
        fi
        echo "  → installing $pkg"
        sudo dnf install -y --allowerasing "$pkg"
    }

    for pkg in \
        neovim tmux zsh git git-delta stow curl \
        gcc make cmake nodejs npm python3 cargo \
        ripgrep fzf fd-find bat zoxide \
        direnv btop entr xclip wl-clipboard jq gh age \
        ffmpeg p7zip p7zip-plugins poppler-utils ImageMagick \
        ansible-core kubectl helm procs tealdeer python3-setuptools du-dust \
        ibus ibus-gtk3 ibus-gtk4; do
        dnf_install "$pkg"
    done

    if ! command -v thefuck &>/dev/null; then
        pipx install thefuck 2>/dev/null || echo "Install thefuck: pipx install thefuck"
    fi

    if ! command -v eza &>/dev/null; then
        if ! dnf copr list --enabled 2>/dev/null | grep -q 'alternateved/eza'; then
            sudo dnf copr enable alternateved/eza -y
        fi
        dnf_install eza
    fi

    if ! command -v dust &>/dev/null; then
        cargo install du-dust 2>/dev/null || echo "Install dust: cargo install du-dust (requires cargo)"
    fi

    if bin_needs_update starship starship "{{starship_version}}"; then
        url="https://github.com/starship/starship/releases/download/v{{starship_version}}/starship-x86_64-unknown-linux-gnu.tar.gz"
        install_release starship "{{starship_version}}" "$HOME/.local/bin/starship" \
            "$url" "$(gh_sha_sidecar "$url")" tar
    fi

    if bin_needs_update atuin atuin "{{atuin_version}}"; then
        url="https://github.com/atuinsh/atuin/releases/download/v{{atuin_version}}/atuin-x86_64-unknown-linux-gnu.tar.gz"
        install_release atuin "{{atuin_version}}" "$HOME/.local/bin/atuin" \
            "$url" "$(gh_sha_sidecar "$url")" tar
    fi
    [[ -d "$HOME/.atuin/bin" ]] && export PATH="$HOME/.atuin/bin:$PATH"

    if ! command -v lazygit &>/dev/null; then
        if ! dnf copr list --enabled 2>/dev/null | grep -q 'atim/lazygit'; then
            sudo dnf copr enable atim/lazygit -y
        fi
        dnf_install lazygit
    fi

    install_release yazi "{{yazi_version}}" "$HOME/.local/bin/yazi" \
        "https://github.com/sxyazi/yazi/releases/download/v{{yazi_version}}/yazi-x86_64-unknown-linux-gnu.zip" \
        "{{yazi_sha256}}" zip "yazi ya"
    export PATH="$HOME/.local/bin:$PATH"

    just sops-install
    just lint-tools

# ---------------------------------------------------------------------------
# Utilities
# ---------------------------------------------------------------------------

# Clone/sync ZSH plugins and tools at their pinned refs (Renovate-tracked)
zsh-plugins:
    #!/usr/bin/env bash
    set -euo pipefail
    source scripts/justlib.sh
    plugins_dir="$HOME/.config/zsh/plugins"
    tools_dir="$HOME/.config/zsh/tools"
    mkdir -p "$plugins_dir" "$tools_dir"
    git_sync fast-syntax-highlighting "$plugins_dir/fast-syntax-highlighting" \
        "https://github.com/zdharma-continuum/fast-syntax-highlighting.git" "{{fast_syntax_highlighting_version}}"
    git_sync zsh-autosuggestions "$plugins_dir/zsh-autosuggestions" \
        "https://github.com/zsh-users/zsh-autosuggestions.git" "{{zsh_autosuggestions_version}}"
    git_sync zsh-completions "$plugins_dir/zsh-completions" \
        "https://github.com/zsh-users/zsh-completions.git" "{{zsh_completions_version}}"
    git_sync fzf-git.sh "$tools_dir/fzf-git.sh" \
        "https://github.com/junegunn/fzf-git.sh.git" "{{fzf_git_sh_commit}}"

# Clone personal shell tools (https://github.com/Aapok0/tools)
tools-clone:
    #!/usr/bin/env bash
    set -euo pipefail
    tools_dir="$HOME/Workspace/tools"
    tools_repo="git@github.com:Aapok0/tools.git"
    if [[ -d "$tools_dir/.git" ]]; then
        echo "  ✓ tools already cloned"
    else
        mkdir -p "$HOME/Workspace"
        echo "  → cloning tools"
        git clone "$tools_repo" "$tools_dir"
    fi
    chmod +x "$tools_dir"/*
    echo "  ✓ tools ready at $tools_dir (on PATH via zsh config)"

# Clone/sync TPM (tmux plugin manager) at its pinned tag (Renovate-tracked)
tpm-install:
    #!/usr/bin/env bash
    set -euo pipefail
    source scripts/justlib.sh
    tpm_dir="$HOME/.config/tmux/plugins/tpm"
    git_sync tpm "$tpm_dir" "https://github.com/tmux-plugins/tpm.git" "{{tpm_version}}"
    if [[ -x "$tpm_dir/bin/install_plugins" ]]; then
        echo "  → installing tmux plugins"
        "$tpm_dir/bin/install_plugins"
        echo "  ✓ tmux plugins installed (or already up to date)"
    fi

# Install JetBrainsMono Nerd Font
font-install:
    #!/usr/bin/env bash
    set -euo pipefail
    source scripts/justlib.sh
    os="$(uname -s)"
    if [[ "$os" == "Darwin" ]]; then
        echo "  ℹ Font installed via Brewfile (font-jetbrains-mono-nerd-font)"
    elif [[ "$os" == "Linux" ]]; then
        if command -v pacman &>/dev/null; then
            sudo pacman -S --needed --noconfirm ttf-jetbrains-mono-nerd
        elif command -v dnf &>/dev/null; then
            if fc-list | grep -qi "JetBrainsMono.*Nerd"; then
                echo "  ✓ JetBrainsMono Nerd Font already installed"
            else
                sudo dnf install -y jetbrains-mono-fonts-all
                echo "  ℹ Install Nerd Font patched version from https://www.nerdfonts.com/font-downloads if needed"
            fi
        elif command -v apt-get &>/dev/null; then
            mkdir -p "$HOME/.local/share/fonts"
            if [[ "$(marker_get nerdfonts)" == "{{nerdfonts_version}}" ]] && fc-list | grep -qi "JetBrainsMono.*Nerd"; then
                echo "  ✓ JetBrainsMono Nerd Font {{nerdfonts_version}} (up to date)"
            else
                echo "  → Downloading JetBrainsMono Nerd Font {{nerdfonts_version}}..."
                tmp="$(mktemp -d)"
                dl_verify \
                    "https://github.com/ryanoasis/nerd-fonts/releases/download/v{{nerdfonts_version}}/JetBrainsMono.tar.xz" \
                    "$tmp/JetBrainsMono.tar.xz" "{{nerdfonts_jetbrainsmono_sha256}}"
                tar xf "$tmp/JetBrainsMono.tar.xz" -C "$HOME/.local/share/fonts/"
                rm -rf "$tmp"
                fc-cache -fv
                marker_set nerdfonts "{{nerdfonts_version}}"
                echo "  ✓ JetBrainsMono Nerd Font installed"
            fi
        else
            echo "  ⚠ No supported package manager found, install JetBrainsMono Nerd Font manually"
        fi
    fi

# Import shell history into atuin (skips if already imported)
atuin-import:
    #!/usr/bin/env bash
    set -euo pipefail
    marker="$HOME/.local/share/atuin/.import-done"
    if [[ -f "$marker" ]]; then
        echo "  ✓ atuin history already imported"
    else
        atuin import auto
        mkdir -p "$(dirname "$marker")"
        touch "$marker"
        echo "  ✓ atuin history imported"
    fi

# Install Ghostty desktop override (dead keys / Finnish ~ on Linux GTK)
ghostty-desktop:
    #!/usr/bin/env bash
    set -euo pipefail
    if [[ "$(uname -s)" != "Linux" ]]; then
        exit 0
    fi
    if ! command -v ghostty &>/dev/null; then
        echo "  ⚠ ghostty not installed, skipping desktop override"
        exit 0
    fi
    mkdir -p "$HOME/.local/bin" "$HOME/.local/share/applications"
    install -m 755 ghostty/bin/ghostty-launch "$HOME/.local/bin/ghostty-launch"
    sed "s|@HOME@|$HOME|g" ghostty/desktop/com.mitchellh.ghostty.desktop.in \
        > "$HOME/.local/share/applications/com.mitchellh.ghostty.desktop"
    if command -v ibus-daemon &>/dev/null; then
        systemctl --user enable --now org.freedesktop.IBus.session.generic.service 2>/dev/null \
            || ibus-daemon -drx &
    fi
    if command -v update-desktop-database &>/dev/null; then
        update-desktop-database "$HOME/.local/share/applications" 2>/dev/null || true
    fi
    echo "  ✓ Ghostty launch wrapper + desktop override installed"
    echo "  ℹ Quit all Ghostty windows, then reopen from menu (Ctrl+Alt+T)"

# Install yazi catppuccin theme
yazi-theme:
    #!/usr/bin/env bash
    set -euo pipefail
    if ! command -v ya &>/dev/null; then
        echo "  ⚠ ya not found (install yazi first)"
        exit 0
    fi
    if [[ -d "$HOME/.config/yazi" ]]; then
        export YAZI_CONFIG_HOME="$HOME/.config/yazi"
    elif [[ -d yazi/.config/yazi ]]; then
        export YAZI_CONFIG_HOME="$(pwd)/yazi/.config/yazi"
    fi
    pkg_toml="${YAZI_CONFIG_HOME:-$HOME/.config/yazi}/package.toml"
    if [[ -f "$pkg_toml" ]] && grep -q '^\[\[flavor\.deps\]\]' "$pkg_toml"; then
        ya pkg install
        echo "  ✓ yazi flavors installed from package.toml"
    elif ya pkg list 2>/dev/null | grep -q 'catppuccin-mocha'; then
        echo "  ✓ catppuccin-mocha already installed"
    else
        ya pkg add yazi-rs/flavors:catppuccin-mocha
        echo "  ✓ catppuccin-mocha installed"
    fi

# Sync Neovim plugins (LSP servers auto-install via mason-lspconfig on first load)
nvim-plugins:
    #!/usr/bin/env bash
    set -euo pipefail
    if ! command -v nvim &>/dev/null; then
        echo "  ⚠ nvim not installed, skipping"
        exit 0
    fi
    echo "  → syncing Lazy.nvim plugins"
    nvim --headless "+Lazy! sync" +qa
    echo "  ✓ nvim plugins synced"

# conform/nvim-lint resolve binaries from $PATH, so a system install covers nvim too.
# Distro repos first, official installers/cargo/npm fallback; macOS: see Brewfile.

# Install linters/formatters system-wide (shared by shell + nvim + CI parity).
# Folded into the distro *-install recipes, so a single `just <distro>-install` covers it.
lint-tools:
    #!/usr/bin/env bash
    set -euo pipefail
    source scripts/justlib.sh
    os="$(uname -s)"
    if [[ "$os" == "Darwin" ]]; then
        echo "  ℹ macOS: installed via Brewfile (just brew-install)"
        exit 0
    fi

    have() { command -v "$1" &>/dev/null; }
    mkdir -p "$HOME/.local/bin"

    # Tools available in distro repos: shellcheck, shfmt, ansible-lint.
    # ruff is intentionally NOT installed here — it's pinned below to ~/.local/bin
    # as the single Renovate-tracked source on every distro.
    if have pacman; then
        sudo pacman -S --needed --noconfirm shellcheck shfmt ansible-lint
    elif have dnf; then
        for pkg in ShellCheck shfmt ansible-lint; do
            if rpm -q "$pkg" &>/dev/null; then
                echo "  ✓ $pkg (already installed)"
            else
                echo "  → installing $pkg"
                sudo dnf install -y "$pkg"
            fi
        done
    elif have apt-get; then
        sudo apt-get update
        sudo apt-get install -y shellcheck shfmt ansible-lint
    fi

    # ruff — pinned prebuilt binary (verified against upstream .sha256); the single
    # source on all distros, installed to ~/.local/bin so Renovate controls the version.
    if bin_needs_update ruff ruff "{{ruff_version}}"; then
        case "$(uname -m)" in
            x86_64) ruff_arch="x86_64-unknown-linux-gnu" ;;
            aarch64 | arm64) ruff_arch="aarch64-unknown-linux-gnu" ;;
            *) ruff_arch="" ;;
        esac
        if [[ -n "$ruff_arch" ]]; then
            url="https://github.com/astral-sh/ruff/releases/download/{{ruff_version}}/ruff-${ruff_arch}.tar.gz"
            install_release ruff "{{ruff_version}}" "$HOME/.local/bin/ruff" \
                "$url" "$(gh_sha_sidecar "$url")" tar
        else
            echo "  ⚠ unsupported arch for ruff: $(uname -m)"
        fi
    fi

    # ty — pinned prebuilt binary (Astral Python type checker); same pattern as ruff.
    if bin_needs_update ty ty "{{ty_version}}"; then
        case "$(uname -m)" in
            x86_64) ty_arch="x86_64-unknown-linux-gnu" ;;
            aarch64 | arm64) ty_arch="aarch64-unknown-linux-gnu" ;;
            *) ty_arch="" ;;
        esac
        if [[ -n "$ty_arch" ]]; then
            url="https://github.com/astral-sh/ty/releases/download/{{ty_version}}/ty-${ty_arch}.tar.gz"
            install_release ty "{{ty_version}}" "$HOME/.local/bin/ty" \
                "$url" "$(gh_sha_sidecar "$url")" tar
        else
            echo "  ⚠ unsupported arch for ty: $(uname -m)"
        fi
    fi

    # ansible-lint — pipx fallback (official recommended) when not in repos
    if ! have ansible-lint; then
        echo "  → installing ansible-lint (pipx)"
        pipx install ansible-lint 2>/dev/null || echo "  ⚠ install ansible-lint manually: pipx install ansible-lint"
    fi

    # stylua — not packaged; build via cargo at the pinned version (official method)
    if bin_needs_update stylua stylua "{{stylua_version}}"; then
        echo "  → installing stylua {{stylua_version}} (cargo)"
        if cargo install stylua --locked --version {{stylua_version}}; then
            marker_set stylua "{{stylua_version}}"
        else
            echo "  ⚠ install stylua manually: cargo install stylua --version {{stylua_version}} (needs cargo)"
        fi
    fi

    # prettier — official method is npm global install (pinned)
    if bin_needs_update prettier prettier "{{prettier_version}}"; then
        echo "  → installing prettier {{prettier_version}} (npm)"
        if npm install -g "prettier@{{prettier_version}}"; then
            marker_set prettier "{{prettier_version}}"
        else
            echo "  ⚠ install prettier manually: npm install -g prettier@{{prettier_version}} (needs npm)"
        fi
    fi

    # hadolint — pinned prebuilt binary, verified against upstream .sha256
    if bin_needs_update hadolint hadolint "{{hadolint_version}}"; then
        case "$(uname -m)" in
            x86_64) hl_arch="x86_64" ;;
            aarch64 | arm64) hl_arch="arm64" ;;
            *) hl_arch="" ;;
        esac
        if [[ -n "$hl_arch" ]]; then
            url="https://github.com/hadolint/hadolint/releases/download/v{{hadolint_version}}/hadolint-linux-${hl_arch}"
            install_release hadolint "{{hadolint_version}}" "$HOME/.local/bin/hadolint" \
                "$url" "$(gh_sha_sidecar "$url")" raw
        else
            echo "  ⚠ unsupported arch for hadolint: $(uname -m)"
        fi
    fi

    # tflint — pinned prebuilt binary, verified against upstream checksums.txt
    if bin_needs_update tflint tflint "{{tflint_version}}"; then
        case "$(uname -m)" in
            x86_64) tf_arch="amd64" ;;
            aarch64 | arm64) tf_arch="arm64" ;;
            *) tf_arch="" ;;
        esac
        if [[ -n "$tf_arch" ]]; then
            asset="tflint_linux_${tf_arch}.zip"
            base="https://github.com/terraform-linters/tflint/releases/download/v{{tflint_version}}"
            install_release tflint "{{tflint_version}}" "$HOME/.local/bin/tflint" \
                "$base/$asset" "$(gh_sha_checksums "$base" "$asset")" zip
        else
            echo "  ⚠ unsupported arch for tflint: $(uname -m)"
        fi
    fi

    # luacheck — Lua linter (CI uses it). In Arch repos; elsewhere via luarocks.
    if ! have luacheck; then
        echo "  → installing luacheck"
        if have pacman; then
            sudo pacman -S --needed --noconfirm luacheck
        elif have dnf; then
            sudo dnf install -y luarocks lua-devel && sudo luarocks install luacheck \
                || echo "  ⚠ install luacheck manually: sudo luarocks install luacheck"
        elif have apt-get; then
            sudo apt-get install -y lua5.4 liblua5.4-dev luarocks && sudo luarocks install luacheck \
                || echo "  ⚠ install luacheck manually: sudo luarocks install luacheck"
        fi
    fi

    # taplo — TOML linter/formatter. Pinned binary (gzip of the raw executable);
    # no upstream checksum, so the SHA256 is pinned locally (x86_64 only).
    if bin_needs_update taplo taplo "{{taplo_version}}"; then
        if [[ "$(uname -m)" == "x86_64" ]]; then
            install_release taplo "{{taplo_version}}" "$HOME/.local/bin/taplo" \
                "https://github.com/tamasfe/taplo/releases/download/{{taplo_version}}/taplo-linux-x86_64.gz" \
                "{{taplo_sha256}}" gz
        else
            echo "  ⚠ taplo pinned binary is x86_64 only; skipping on $(uname -m)"
        fi
    fi

    # gitleaks — secret scanner (CI uses it). Pinned binary, verified against
    # the upstream checksums file.
    if bin_needs_update gitleaks gitleaks "{{gitleaks_version}}"; then
        case "$(uname -m)" in
            x86_64) gl_arch="x64" ;;
            aarch64 | arm64) gl_arch="arm64" ;;
            *) gl_arch="" ;;
        esac
        if [[ -n "$gl_arch" ]]; then
            asset="gitleaks_{{gitleaks_version}}_linux_${gl_arch}.tar.gz"
            base="https://github.com/gitleaks/gitleaks/releases/download/v{{gitleaks_version}}"
            sha="$(gh_sha_checksums "$base" "$asset" "gitleaks_{{gitleaks_version}}_checksums.txt")"
            install_release gitleaks "{{gitleaks_version}}" "$HOME/.local/bin/gitleaks" \
                "$base/$asset" "$sha" tar
        else
            echo "  ⚠ unsupported arch for gitleaks: $(uname -m)"
        fi
    fi

    echo "  ✓ linters/formatters installed"

# Install sops from GitHub (not in Debian/Fedora repos; Arch: pacman extra/sops)
sops-install:
    #!/usr/bin/env bash
    set -euo pipefail
    source scripts/justlib.sh
    if ! bin_needs_update sops sops "{{sops_version}}"; then
        exit 0
    fi
    arch="$(uname -m)"
    case "$arch" in
        x86_64) asset="sops-v{{sops_version}}.linux.amd64" ;;
        aarch64) asset="sops-v{{sops_version}}.linux.arm64" ;;
        *)
            echo "Pinned sops has no binary for $arch; install manually: https://github.com/getsops/sops/releases"
            exit 1
            ;;
    esac
    base="https://github.com/getsops/sops/releases/download/v{{sops_version}}"
    install_release sops "{{sops_version}}" /usr/local/bin/sops \
        "$base/$asset" "$(gh_sha_checksums "$base" "$asset" "sops-v{{sops_version}}.checksums.txt")" raw

# Install tfswitch (Terraform version manager; replaces distro terraform package)
tfswitch-install:
    #!/usr/bin/env bash
    set -euo pipefail
    source scripts/justlib.sh
    if bin_needs_update tfswitch tfswitch "{{tfswitch_version}}"; then
        asset="terraform-switcher_v{{tfswitch_version}}_linux_amd64.tar.gz"
        base="https://github.com/warrensbox/terraform-switcher/releases/download/v{{tfswitch_version}}"
        sha="$(gh_sha_checksums "$base" "$asset" "terraform-switcher_v{{tfswitch_version}}_checksums.txt")"
        install_release tfswitch "{{tfswitch_version}}" "$HOME/.local/bin/tfswitch" \
            "$base/$asset" "$sha" tar
    else
        echo "  ✓ tfswitch {{tfswitch_version}} (up to date)"
    fi

# Set default shell to zsh (no-op if already zsh)
set-shell:
    #!/usr/bin/env bash
    set -euo pipefail
    if [[ "$(uname -s)" == "Darwin" ]]; then
        current_shell="$(dscl . -read "/Users/$USER" UserShell | awk '{print $2}')"
    else
        current_shell="$(getent passwd "$USER" | cut -d: -f7)"
    fi
    if [[ "$current_shell" == *zsh ]]; then
        echo "  ✓ zsh is already the default shell"
    else
        zsh_path="$(command -v zsh)"
        os="$(uname -s)"
        if [[ "$os" == "Darwin" ]]; then
            chsh -s "$zsh_path"
        else
            sudo chsh -s "$zsh_path" "$USER"
        fi
        echo "  → default shell changed to $zsh_path (log out and back in to take effect)"
    fi

# Check if all required tools are installed
check:
    #!/usr/bin/env bash
    set -euo pipefail
    have_cmd() {
        case "$1" in
            fd) command -v fd &>/dev/null || command -v fdfind &>/dev/null ;;
            rg) command -v rg &>/dev/null || command -v ripgrep &>/dev/null ;;
            atuin) command -v atuin &>/dev/null || [[ -x "$HOME/.atuin/bin/atuin" ]] ;;
            yazi) command -v yazi &>/dev/null || command -v ya &>/dev/null ;;
            *) command -v "$1" &>/dev/null ;;
        esac
    }
    missing=0
    missing_list=""
    for cmd in nvim tmux zsh git stow starship zoxide fzf fd rg bat eza delta atuin lazygit yazi; do
        if ! have_cmd "$cmd"; then
            missing=1
            if [ -z "$missing_list" ]; then
                missing_list="$cmd"
            else
                missing_list="$missing_list $cmd"
            fi
        fi
    done
    if [ "$missing" -eq 0 ]; then
        echo "All core tools installed."
    else
        echo "Missing tools: $missing_list"
        exit 1
    fi

# ---------------------------------------------------------------------------
# Full Install
# ---------------------------------------------------------------------------

# Full environment setup: install packages, stow configs, clone plugins, change default shell, and verify installation
install:
    #!/usr/bin/env bash
    set -euo pipefail
    os="$(uname -s)"
    echo "=== Dotfiles full install ==="
    echo ""

    echo "── Installing packages ──"
    if [[ "$os" == "Darwin" ]]; then
        if command -v brew &>/dev/null; then
            just brew-install
        else
            echo "Homebrew not found. Install from https://brew.sh"
            exit 1
        fi
    elif [[ "$os" == "Linux" ]]; then
        if command -v pacman &>/dev/null; then
            just pacman-install
        elif command -v dnf &>/dev/null; then
            just dnf-install
        elif command -v apt-get &>/dev/null; then
            just apt-install
        else
            echo "No supported package manager found (brew/pacman/dnf/apt)"
            exit 1
        fi
    else
        echo "Unsupported OS: $os"
        exit 1
    fi
    echo ""

    if [[ "$os" == "Linux" ]]; then
        echo "── tfswitch (Terraform versions) ──"
        just tfswitch-install
        echo ""
    fi

    echo "── Font ──"
    just font-install
    echo ""

    echo "── Restowing configs ──"
    just restow-all
    echo ""

    if [[ "$os" == "Linux" ]]; then
        echo "── Ghostty desktop (Linux dead keys) ──"
        just ghostty-desktop
        echo ""
    fi

    echo "── ZSH plugins ──"
    just zsh-plugins
    echo ""

    echo "── Personal tools ──"
    just tools-clone
    echo ""

    echo "── TPM (tmux plugin manager) ──"
    just tpm-install
    echo ""

    echo "── Neovim plugins ──"
    just nvim-plugins
    echo ""

    echo "── Yazi theme ──"
    if command -v ya &>/dev/null; then
        just yazi-theme
    else
        echo "  ⚠ yazi not installed, skipping theme"
    fi
    echo ""

    echo "── Atuin history import ──"
    if command -v atuin &>/dev/null; then
        just atuin-import
    else
        echo "  ⚠ atuin not installed, skipping import"
    fi
    echo ""

    echo "── Default shell ──"
    just set-shell
    echo ""

    echo "── Verification ──"
    just check
    echo ""
    echo "=== Done ==="
    echo "Next steps:"
    echo "  • Log out and back in (or run 'exec zsh') to use zsh"
