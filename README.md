# Dotfiles

Configuration files for CLI tools and development environments on Linux and macOS, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Setup

### 1. Install stow

```bash
# Debian
sudo apt install stow

# Arch
sudo pacman -S stow

# Fedora
sudo dnf install stow

# macOS
brew install stow
```

### 2. Symlink configurations (from the dotfiles directory)

```bash
# Selected configurations
stow -vRt $HOME <directory-name>

# All configurations
stow -vRt $HOME */
```

### 3. Remove configurations

```bash
# Selected configurations
stow -vDt $HOME <directory-name>

# All configurations
stow -vDt $HOME */
```

## Configurations

More details can be found in the README of each subdirectory.

### bat

A `cat` replacement with syntax highlighting. Uses the Catppuccin Mocha theme.

### gitconfig

Git configuration with sensible defaults, extensive aliases, and delta integration for syntax-highlighted diffs.

#### Requirements

- [git-delta](https://github.com/dandavella/delta)

#### Setup

Create a local config for your credentials at `~/.config/git/config.local`.

### kitty

GPU-accelerated terminal emulator with Catppuccin colors and transparency.

#### Requirements

Font:

- Meslo Nerd Font (Linux)
- Fira Code Nerd Font (macOS)

### lightdm

Display manager and slick-greeter configuration for the login screen. Linux only.

#### Requirements

- lightdm
- lightdm-slick-greeter

### nvim

Neovim configuration in Lua with lazy.nvim plugin manager. Includes LSP support, Telescope fuzzy finder, Treesitter, GitHub Copilot, and more.

#### Requirements

- ripgrep
- A [Nerd Font](https://www.nerdfonts.com/)
- npm (for some LSP servers)
- python3

#### Setup

1. Symlink the config with stow
2. Open Neovim — plugins auto-install via lazy.nvim
3. Run `:Mason` to install LSP servers and formatters

### starship

Cross-shell prompt configuration using a modified Gruvbox preset.

#### Requirements

- [Starship](https://starship.rs/)

### tmux

Terminal multiplexer configuration with TPM plugin manager and vim-tmux-navigator integration.

#### Requirements

- [TPM](https://github.com/tmux-plugins/tpm) — clone to `~/tmux/plugins/tpm`

#### Setup

After symlinking, press `prefix + I` inside tmux to install plugins.

### tmux-tools

Two utility scripts for creating/attaching tmux sessions using directory names:

- `tmuxz` — create/attach a session by zoxide keyword
- `tmuxf` — fuzzy-find a zoxide directory with fzf and create/attach a session

#### Requirements

- tmux
- zoxide
- fzf

### vim

Legacy Vim configuration with Vundle. Neovim is preferred — see `nvim` above.

#### Requirements

- A [Nerd Font](https://www.nerdfonts.com/) (for NERDTree icons)

### zsh

Cross-platform ZSH configuration with automatic OS/distro detection, completion caching, SSH key auto-loading, and PATH deduplication. Uses Starship for the prompt.

#### Requirements

Plugins (clone to `~/.config/zsh/plugins/`):

- [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-completions](https://github.com/zsh-users/zsh-completions)
- [fzf-git.sh](https://github.com/junegunn/fzf-git.sh)

Tools:

- eza
- bat
- fzf
- zoxide
- fd
- starship

#### Setup

Use `~/.zshrc.local` for machine-specific settings (not tracked by git).
