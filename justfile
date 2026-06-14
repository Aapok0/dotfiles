# Dotfiles management
# Usage: just <recipe>
# List recipes: just --list

# Default recipe — show available commands
default:
    @just --list

# Default terminal emulator (kitty, wezterm, or ghostty)
terminal := "ghostty"

# Core configs to stow (always included)
core_dirs := "bat gitconfig nvim starship tmux tmux-tools vim zsh lazygit yazi atuin"

# ──── Stow ────────────────────────────────────────────────

# Stow/unstow/restow all dotfiles (uses default terminal, override with: just terminal=ghostty stow-all)
stow-all:
    @echo "Stowing all configs (terminal: {{terminal}})..."
    @for dir in {{terminal}} {{core_dirs}}; do \
        if [ -d "$dir" ]; then \
            echo "  → $dir"; \
            if [ "$dir" = "atuin" ] && [ -f "$HOME/.config/atuin/config.toml" ] && [ ! -L "$HOME/.config/atuin/config.toml" ]; then \
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
            if [ "$dir" = "atuin" ] && [ -f "$HOME/.config/atuin/config.toml" ] && [ ! -L "$HOME/.config/atuin/config.toml" ]; then \
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
        if [[ -f "$target" && ! -L "$target" ]]; then
            echo "  → replacing installer atuin config with dotfiles version"
            rm -f "$target"
        fi
    fi
    stow -v --target="$HOME" "{{name}}"

unstow name:
    stow -v -D --target="$HOME" {{name}}

# ──── macOS Setup ─────────────────────────────────────────

brew-install:
    brew bundle --file=Brewfile

# Check what's missing from Brewfile
brew-check:
    brew bundle check --file=Brewfile --verbose

# ──── Linux Setup ─────────────────────────────────────────

# Install core dependencies
# Debian (packages not in default repos are installed via alternative methods)
apt-install:
    #!/usr/bin/env bash
    set -euo pipefail
    sudo apt-get update
    sudo apt-get install -y \
        neovim tmux zsh git stow curl cargo \
        build-essential cmake nodejs npm python3 \
        ripgrep fzf fd-find bat \
        direnv thefuck tldr \
        btop entr xclip wl-clipboard jq \
        ffmpeg p7zip-full poppler-utils imagemagick \
        ansible kubectl helm

    if ! command -v eza &>/dev/null; then
        if [[ ! -f /etc/apt/sources.list.d/gierens.list ]]; then
            sudo mkdir -p /etc/apt/keyrings
            wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
            echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
        fi
        sudo apt-get update && sudo apt-get install -y eza
    fi

    if ! command -v delta &>/dev/null; then
        arch="$(dpkg --print-architecture)"
        case "$arch" in
            amd64) delta_arch="amd64" ;;
            arm64) delta_arch="arm64" ;;
            *)
                echo "Unsupported architecture for git-delta: $arch"
                echo "Install manually: https://github.com/dandavison/delta/releases"
                exit 1
                ;;
        esac
        DELTA_VERSION=$(curl -s "https://api.github.com/repos/dandavison/delta/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
        curl -fsSL -o /tmp/git-delta.deb "https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/git-delta_${DELTA_VERSION}_${delta_arch}.deb"
        sudo dpkg -i /tmp/git-delta.deb || sudo apt-get install -f -y
        rm -f /tmp/git-delta.deb
    fi

    if ! command -v zoxide &>/dev/null; then
        curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
    fi

    if ! command -v starship &>/dev/null; then
        curl -sS https://starship.rs/install.sh | sh -s -- -y
    fi

    if ! command -v atuin &>/dev/null; then
        bash <(curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh)
    fi

    if ! command -v lazygit &>/dev/null; then
        LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
        curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
        tar xf /tmp/lazygit.tar.gz -C /tmp lazygit
        sudo install /tmp/lazygit /usr/local/bin && rm /tmp/lazygit /tmp/lazygit.tar.gz
    fi

    if ! command -v yazi &>/dev/null; then
        cargo install --locked yazi-fm yazi-cli 2>/dev/null || echo "Install yazi: cargo install --locked yazi-fm yazi-cli (requires cargo)"
    fi

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

# Arch (official repos)
pacman-install:
    sudo pacman -S --needed \
        neovim tmux zsh git git-delta stow curl \
        base-devel cmake nodejs npm python \
        ripgrep fzf fd bat eza zoxide starship dust procs \
        atuin direnv thefuck tldr \
        lazygit yazi btop entr xclip wl-clipboard jq github-cli \
        ffmpeg p7zip poppler imagemagick \
        ansible kubectl helm

# Fedora — one package per dnf install (already-installed RPMs must not be batched)
dnf-install:
    #!/usr/bin/env bash
    set -euo pipefail

    dnf_install() {
        local pkg=$1
        if rpm -q "$pkg" &>/dev/null; then
            echo "  ✓ $pkg (already installed)"
            return 0
        fi
        echo "  → installing $pkg"
        sudo dnf install -y "$pkg"
    }

    for pkg in \
        neovim tmux zsh git git-delta stow curl \
        gcc make cmake nodejs npm python3 \
        ripgrep fzf fd-find bat zoxide \
        direnv btop entr xclip wl-clipboard jq gh \
        ffmpeg-free p7zip p7zip-plugins poppler-utils ImageMagick \
        ansible-core kubectl helm procs tealdeer python3-setuptools du-dust; do
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

    if ! command -v starship &>/dev/null; then
        curl -sS https://starship.rs/install.sh | sh -s -- -y
    fi

    if ! command -v atuin &>/dev/null; then
        bash <(curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh)
    fi
    [[ -d "$HOME/.atuin/bin" ]] && export PATH="$HOME/.atuin/bin:$PATH"

    if ! command -v lazygit &>/dev/null; then
        if ! dnf copr list --enabled 2>/dev/null | grep -q 'atim/lazygit'; then
            sudo dnf copr enable atim/lazygit -y
        fi
        dnf_install lazygit
    fi

    if ! command -v yazi &>/dev/null && ! command -v ya &>/dev/null; then
        echo "  → installing yazi (prebuilt binary)"
        tmp=$(mktemp -d)
        curl -fsSL -o "$tmp/yazi.zip" \
            "https://github.com/sxyazi/yazi/releases/latest/download/yazi-x86_64-unknown-linux-gnu.zip"
        unzip -q "$tmp/yazi.zip" -d "$tmp/extract"
        arch_dir=$(find "$tmp/extract" -mindepth 1 -maxdepth 1 -type d | head -1)
        mkdir -p "$HOME/.local/bin"
        install -m 755 "$arch_dir/yazi" "$arch_dir/ya" "$HOME/.local/bin/"
        rm -rf "$tmp"
        echo "  ✓ yazi installed to ~/.local/bin"
    fi
    export PATH="$HOME/.local/bin:$PATH"

# Install tfswitch (Terraform version manager; replaces distro terraform package)
tfswitch-install:
    #!/usr/bin/env bash
    set -euo pipefail
    if command -v tfswitch &>/dev/null; then
        echo "  ✓ tfswitch already installed"
        exit 0
    fi
    mkdir -p "$HOME/.local/bin"
    curl -fsSL https://raw.githubusercontent.com/warrensbox/terraform-switcher/master/install.sh | bash -s -- -b "$HOME/.local/bin"
    echo "  ✓ tfswitch installed to ~/.local/bin/tfswitch"

# ──── Utilities ───────────────────────────────────────────

# Clone ZSH plugins and tools
zsh-plugins:
    #!/usr/bin/env bash
    set -euo pipefail
    plugins_dir="$HOME/.config/zsh/plugins"
    tools_dir="$HOME/.config/zsh/tools"
    mkdir -p "$plugins_dir" "$tools_dir"
    declare -A plugins=(
        [fast-syntax-highlighting]="https://github.com/zdharma-continuum/fast-syntax-highlighting.git"
        [zsh-autosuggestions]="https://github.com/zsh-users/zsh-autosuggestions.git"
        [zsh-completions]="https://github.com/zsh-users/zsh-completions.git"
    )
    for name in "${!plugins[@]}"; do
        if [[ -d "$plugins_dir/$name/.git" ]]; then
            echo "  ✓ $name (already cloned)"
        else
            echo "  → cloning $name"
            git clone "${plugins[$name]}" "$plugins_dir/$name"
        fi
    done
    if [[ -d "$tools_dir/fzf-git.sh/.git" ]]; then
        echo "  ✓ fzf-git.sh (already cloned)"
    else
        echo "  → cloning fzf-git.sh"
        git clone "https://github.com/junegunn/fzf-git.sh.git" "$tools_dir/fzf-git.sh"
    fi

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

# Clone TPM (tmux plugin manager)
tpm-install:
    #!/usr/bin/env bash
    set -euo pipefail
    tpm_dir="$HOME/.config/tmux/plugins/tpm"
    if [[ -d "$tpm_dir/.git" ]]; then
        echo "  ✓ TPM already installed"
    else
        echo "  → cloning TPM"
        git clone "https://github.com/tmux-plugins/tpm.git" "$tpm_dir"
    fi
    if [[ -x "$tpm_dir/bin/install_plugins" ]]; then
        echo "  → installing tmux plugins"
        "$tpm_dir/bin/install_plugins"
        echo "  ✓ tmux plugins installed (or already up to date)"
    fi

# Install JetBrainsMono Nerd Font
font-install:
    #!/usr/bin/env bash
    set -euo pipefail
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
            if fc-list | grep -qi "JetBrainsMono.*Nerd"; then
                echo "  ✓ JetBrainsMono Nerd Font already installed"
            else
                echo "  → Downloading JetBrainsMono Nerd Font..."
                curl -fsSL -o /tmp/JetBrainsMono.tar.xz "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz"
                tar xf /tmp/JetBrainsMono.tar.xz -C "$HOME/.local/share/fonts/"
                rm /tmp/JetBrainsMono.tar.xz
                fc-cache -fv
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

# Sync Neovim plugins and Mason tools
nvim-plugins:
    #!/usr/bin/env bash
    set -euo pipefail
    if ! command -v nvim &>/dev/null; then
        echo "  ⚠ nvim not installed, skipping"
        exit 0
    fi
    echo "  → syncing Lazy.nvim plugins"
    nvim --headless "+Lazy! sync" +qa
    echo "  → installing Mason tools"
    nvim --headless "+MasonInstall shellcheck shfmt stylua prettier ruff hadolint tflint ansible-lint" +qa
    echo "  ✓ nvim plugins and Mason tools synced"

# Set default shell to zsh (no-op if already zsh)
set-shell:
    #!/usr/bin/env bash
    set -euo pipefail
    current_shell="$(getent passwd "$USER" | cut -d: -f7)"
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

# ──── Full Install ────────────────────────────────────────

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
