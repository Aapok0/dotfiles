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
        if [ -d "$$dir" ]; then \
            echo "  → $$dir"; \
            stow -v --target="$$HOME" "$$dir" 2>&1 | grep -v "^$"; \
        fi; \
    done
    @echo "Done."

unstow-all:
    @echo "Unstowing all configs (terminal: {{terminal}})..."
    @for dir in {{terminal}} {{core_dirs}}; do \
        if [ -d "$$dir" ]; then \
            echo "  → $$dir"; \
            stow -v -D --target="$$HOME" "$$dir" 2>&1 | grep -v "^$"; \
        fi; \
    done
    @echo "Done."

restow-all:
    @echo "Restowing all configs (terminal: {{terminal}})..."
    @for dir in {{terminal}} {{core_dirs}}; do \
        if [ -d "$$dir" ]; then \
            echo "  → $$dir"; \
            stow -v -R --target="$$HOME" "$$dir" 2>&1 | grep -v "^$"; \
        fi; \
    done
    @echo "Done."

stow name:
    stow -v --target="$HOME" {{name}}

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
        neovim tmux zsh git stow curl \
        build-essential cmake nodejs npm python3 \
        ripgrep fzf fd-find bat \
        direnv thefuck tldr \
        btop entr xclip wl-clipboard jq \
        ffmpeg p7zip-full poppler-utils imagemagick \
        terraform ansible kubectl helm

    if ! command -v eza &>/dev/null; then
        sudo mkdir -p /etc/apt/keyrings
        wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
        echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
        sudo apt-get update && sudo apt-get install -y eza
    fi

    if ! command -v delta &>/dev/null; then
        echo "Install git-delta: https://github.com/dandavtella/delta/releases"
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
        LAZYGIT_VERSION=$$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
        curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_$${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
        tar xf /tmp/lazygit.tar.gz -C /tmp lazygit
        sudo install /tmp/lazygit /usr/local/bin && rm /tmp/lazygit /tmp/lazygit.tar.gz
    fi

    if ! command -v yazi &>/dev/null; then
        cargo install --locked yazi-fm yazi-cli 2>/dev/null || echo "Install yazi: cargo install --locked yazi-fm yazi-cli (requires cargo)"
    fi

    if ! command -v gh &>/dev/null; then
        sudo mkdir -p /etc/apt/keyrings
        curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null
        echo "deb [arch=$$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list
        sudo apt-get update && sudo apt-get install -y gh
    fi

    if ! command -v dust &>/dev/null; then
        cargo install du-dust 2>/dev/null || echo "Install dust: cargo install du-dust (requires cargo)"
    fi
    if ! command -v procs &>/dev/null; then
        cargo install procs 2>/dev/null || echo "Install procs: cargo install procs (requires cargo)"
    fi

# Arch (all packages available in official repos)
pacman-install:
    sudo pacman -S --needed \
        neovim tmux zsh git git-delta stow curl \
        base-devel cmake nodejs npm python \
        ripgrep fzf fd bat eza zoxide starship dust procs \
        atuin direnv thefuck tldr \
        lazygit yazi btop entr xclip wl-clipboard jq github-cli \
        ffmpeg p7zip poppler imagemagick \
        terraform ansible kubectl helm

# Fedora
dnf-install:
    #!/usr/bin/env bash
    set -euo pipefail
    sudo dnf install -y \
        neovim tmux zsh git git-delta stow curl \
        gcc make cmake nodejs npm python3 \
        ripgrep fzf fd-find bat eza zoxide starship dust procs \
        direnv thefuck tldr \
        btop entr xclip wl-clipboard jq gh \
        ffmpeg-free sevenzip poppler-utils ImageMagick \
        terraform ansible kubectl helm

    if ! command -v atuin &>/dev/null; then
        bash <(curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh)
    fi

    if ! command -v lazygit &>/dev/null; then
        sudo dnf copr enable atim/lazygit -y
        sudo dnf install -y lazygit
    fi

    if ! command -v yazi &>/dev/null; then
        cargo install --locked yazi-fm yazi-cli 2>/dev/null || echo "Install yazi: cargo install --locked yazi-fm yazi-cli (requires cargo)"
    fi

# ──── Utilities ───────────────────────────────────────────

# Clone ZSH plugins and tools
zsh-plugins:
    #!/usr/bin/env bash
    set -euo pipefail
    plugins_dir="$HOME/.config/zsh/plugins"
    tools_dir="$HOME/.config/zsh/tools"
    mkdir -p "$$plugins_dir" "$$tools_dir"
    declare -A plugins=(
        [fast-syntax-highlighting]="https://github.com/zdharma-continuum/fast-syntax-highlighting.git"
        [zsh-autosuggestions]="https://github.com/zsh-users/zsh-autosuggestions.git"
        [zsh-completions]="https://github.com/zsh-users/zsh-completions.git"
    )
    for name in "$${!plugins[@]}"; do
        if [[ -d "$$plugins_dir/$$name" ]]; then
            echo "  ✓ $$name (already cloned)"
        else
            echo "  → cloning $$name"
            git clone "$${plugins[$$name]}" "$$plugins_dir/$$name"
        fi
    done
    if [[ -d "$$tools_dir/fzf-git.sh" ]]; then
        echo "  ✓ fzf-git.sh (already cloned)"
    else
        echo "  → cloning fzf-git.sh"
        git clone "https://github.com/junegunn/fzf-git.sh.git" "$$tools_dir/fzf-git.sh"
    fi

# Clone TPM (tmux plugin manager)
tpm-install:
    #!/usr/bin/env bash
    set -euo pipefail
    tpm_dir="$HOME/.config/tmux/plugins/tpm"
    if [[ -d "$$tpm_dir" ]]; then
        echo "  ✓ TPM already installed"
    else
        echo "  → cloning TPM"
        git clone "https://github.com/tmux-plugins/tpm.git" "$$tpm_dir"
    fi
    echo "  ℹ Open tmux and press prefix + I to install plugins"

# Import shell history into atuin
atuin-import:
    atuin import auto

# Install yazi catppuccin theme
yazi-theme:
    ya pkg add yazi-rs/flavors:catppuccin-mocha

# Set default shell to zsh (no-op if already zsh)
set-shell:
    #!/usr/bin/env bash
    set -euo pipefail
    if [[ "$$SHELL" == *zsh ]]; then
        echo "  ✓ zsh is already the default shell"
    else
        zsh_path="$(which zsh)"
        os="$(uname -s)"
        if [[ "$$os" == "Darwin" ]]; then
            chsh -s "$$zsh_path"
        else
            sudo chsh -s "$$zsh_path" "$$USER"
        fi
        echo "  → default shell changed to $$zsh_path (log out and back in to take effect)"
    fi

# Check if all required tools are installed
check:
    #!/usr/bin/env bash
    missing=()
    for cmd in nvim tmux zsh git stow starship zoxide fzf fd rg bat eza delta atuin lazygit yazi; do
        if ! command -v "$$cmd" &>/dev/null; then
            missing+=("$$cmd")
        fi
    done
    if [ $${#missing[@]} -eq 0 ]; then
        echo "All core tools installed."
    else
        echo "Missing tools: $${missing[*]}"
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
    if [[ "$$os" == "Darwin" ]]; then
        if command -v brew &>/dev/null; then
            just brew-install
        else
            echo "Homebrew not found. Install from https://brew.sh"
            exit 1
        fi
    elif [[ "$$os" == "Linux" ]]; then
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
        echo "Unsupported OS: $$os"
        exit 1
    fi
    echo ""

    echo "── Stowing configs ──"
    just stow-all
    echo ""

    echo "── ZSH plugins ──"
    just zsh-plugins
    echo ""

    echo "── TPM (tmux plugin manager) ──"
    just tpm-install
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
    echo "  • If on Debian, install git-delta manually:"
    echo "    1. Download latest release from https://github.com/dandavison/delta/releases"
    echo "    2. Install the downloaded package"
    echo "  • Log out and back in (or run 'exec zsh') to use zsh"
    echo "  • Open nvim and install plugins:"
    echo "    1. nvim"
    echo "    2. Let lazy.nvim install plugins"
    echo "    3. :MasonInstall shellcheck shfmt stylua prettier ruff hadolint tflint ansible-lint"
    echo "  • Open tmux (tmux) and press prefix + I to install tmux plugins"
