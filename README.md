# Dotfiles

Configuration files for CLI tools and development environments on Linux and macOS, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Quick Start

### Full install (recommended)

```bash
# Install prerequisites
# macOS:
brew install stow just
# Arch:
sudo pacman -S stow just
# Fedora:
sudo dnf install stow just
# Debian:
sudo apt-get install stow just

mkdir $HOME/Workspace
git clone <repo-url> $HOME/Workspace/dotfiles
cd $HOME/Workspace/dotfiles

# One command: installs packages, stows configs, clones plugins, sets up themes
just install
```

This auto-detects your OS and runs the appropriate package manager, then stows all configs, clones ZSH plugins and TPM, installs the yazi theme, and imports shell history into atuin.

### Manual / step-by-step

```bash
just brew-install          # or apt-install / pacman-install / dnf-install
just stow-all              # symlink all configs
just zsh-plugins           # clone ZSH plugins
just tpm-install           # clone tmux plugin manager
just set-shell             # change default shell to zsh
just yazi-theme            # install yazi Catppuccin theme
just atuin-import          # import shell history into atuin
just check                 # verify core tools are installed
```

After install, open tmux and press `prefix + I` to install tmux plugins, then `exec zsh` to reload your shell.

### Stow individual configs

```bash
just stow nvim
just stow zsh
just terminal=kitty stow-all   # override default terminal
```

## Task Runner

A [justfile](justfile) automates common operations:

| Command | Description |
|---|---|
| `just install` | **Full setup** — packages, stow, plugins, themes (auto-detects OS) |
| `just stow-all` | Stow all configs (uses default terminal) |
| `just unstow-all` | Remove all symlinks |
| `just restow-all` | Re-stow all (after adding new files) |
| `just stow <name>` | Stow a single config |
| `just unstow <name>` | Unstow a single config |
| `just brew-install` | Install macOS deps via Brewfile |
| `just apt-install` | Install core deps (Debian) |
| `just pacman-install` | Install core deps (Arch) |
| `just dnf-install` | Install core deps (Fedora) |
| `just zsh-plugins` | Clone ZSH plugins (skips existing) |
| `just tpm-install` | Clone TPM for tmux (skips if exists) |
| `just set-shell` | Set default shell to zsh (no-op if already zsh) |
| `just yazi-theme` | Install yazi Catppuccin theme |
| `just atuin-import` | Import shell history into atuin |
| `just check` | Verify all core tools are installed |

Override the default terminal emulator with `just terminal=ghostty <command>`.

## Configurations

### Shell & Prompt

| Config | Description |
|---|---|
| [zsh](zsh/) | Cross-platform ZSH config with OS detection, fzf, atuin history, zoxide, completions, SSH key auto-loading |
| [starship](starship/) | Custom "Dusk" prompt theme — muted pastel powerline with Catppuccin-inspired palette |

### Terminal Emulators

One terminal is stowed by default (configurable via `just terminal=<name>`).

| Config | Description |
|---|---|
| [kitty](kitty/) | GPU-accelerated terminal with Catppuccin Mocha colors, powerline tabs, transparency |
| [wezterm](wezterm/) | Lua-configurable terminal with built-in multiplexing, WebGPU rendering, integrated titlebar |
| [ghostty](ghostty/) | Native-rendering terminal by Mitchell Hashimoto, minimal config, background blur |

All three use **JetBrainsMono Nerd Font** and **Catppuccin Mocha** theme.

### Editor

| Config | Description |
|---|---|
| [nvim](nvim/) | Modern Neovim in Lua — Lazy.nvim, Mason, LSP, Treesitter, Copilot, conform + nvim-lint |
| [vim](vim/) | Legacy Vim config with Vundle (Neovim preferred) |

### Git

| Config | Description |
|---|---|
| [gitconfig](gitconfig/) | Histogram diffs, delta integration, 20+ aliases, auto-upstream, SSH auth |

Requires [git-delta](https://github.com/dandavtella/delta). Create credentials at `~/.config/git/config.local`.

### Terminal Multiplexer

| Config | Description |
|---|---|
| [tmux](tmux/) | Prefix `Ctrl+Space`, vim-aware pane nav, Catppuccin theme, resurrect + continuum |
| [tmux-tools](tmux-tools/) | `tmuxz` and `tmuxf` — create/attach sessions via zoxide + fzf |

### TUI Tools

| Config | Description |
|---|---|
| [lazygit](lazygit/) | Git TUI with Catppuccin Mocha theme, delta pager, Nerd Font icons |
| [yazi](yazi/) | Terminal file manager with Catppuccin Mocha flavor, image preview |
| [atuin](atuin/) | SQLite-backed shell history — fuzzy search, directory-scoped, replaces fzf Ctrl+R |

### Other

| Config | Description |
|---|---|
| [bat](bat/) | `cat` replacement with syntax highlighting, Catppuccin Mocha theme |

## Core Tools

These tools are integrated into the ZSH config and expected to be installed:

### Essential

| Tool | Purpose |
|---|---|
| [neovim](https://neovim.io/) | Editor (aliased to `vim`) |
| [eza](https://github.com/eza-community/eza) | Modern `ls` replacement |
| [bat](https://github.com/sharkdp/bat) | `cat` with syntax highlighting |
| [fzf](https://github.com/junegunn/fzf) | Fuzzy finder (files, dirs, completions) |
| [fd](https://github.com/sharkdp/fd) | Fast `find` replacement |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | Smart `cd` with frecency |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | Fast recursive grep |
| [git-delta](https://github.com/dandavtella/delta) | Syntax-highlighted git diffs |
| [starship](https://starship.rs/) | Cross-shell prompt |
| [atuin](https://github.com/atuinsh/atuin) | Shell history search |

### TUI Applications

| Tool | Purpose |
|---|---|
| [lazygit](https://github.com/jesseduffield/lazygit) | Git TUI client |
| [lazydocker](https://github.com/jesseduffield/lazydocker) | Docker TUI client |
| [yazi](https://github.com/sxyazi/yazi) | Terminal file manager |

### Additional

| Tool | Purpose |
|---|---|
| [tmux](https://github.com/tmux/tmux) | Terminal multiplexer |
| [thefuck](https://github.com/nvbn/thefuck) | Command autocorrection |
| [tldr](https://github.com/tldr-pages/tldr) | Simplified man pages |
| [btop](https://github.com/aristocratos/btop) | System monitor |
| [direnv](https://github.com/direnv/direnv) | Per-directory environment variables |
| [dust](https://github.com/bootandy/dust) | Disk usage analyzer |
| [procs](https://github.com/dalance/procs) | Process viewer |
| [gh](https://cli.github.com/) | GitHub CLI |
| [just](https://github.com/casey/just) | Task runner |

## macOS Setup

A [Brewfile](Brewfile) is included for one-command macOS setup:

```bash
brew bundle --file=Brewfile
```

This installs all CLI tools, fonts, the default terminal emulator, and linters/formatters.

## Font

All configs use **JetBrainsMono Nerd Font**:

```bash
# macOS
brew install --cask font-jetbrains-mono-nerd-font

# Arch
sudo pacman -S ttf-jetbrains-mono-nerd

# Fedora
sudo dnf install jetbrains-mono-fonts-all
# Nerd Font patched version: https://www.nerdfonts.com/font-downloads

# Debian
mkdir -p ~/.local/share/fonts
# Download from https://www.nerdfonts.com/font-downloads
unzip JetBrainsMono.zip -d ~/.local/share/fonts/
fc-cache -fv
```

## Machine-Specific Config

Use `~/.config/zsh/.zshrc.local` for settings specific to one machine (not tracked):

```zsh
export MY_API_KEY="secret"
alias work='cd ~/projects/work'
```

Use `~/.config/git/config.local` for git credentials (not tracked):

```ini
[user]
    name = Your Name
    email = your@email.com
```
