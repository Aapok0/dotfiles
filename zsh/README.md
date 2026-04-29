# ZSH Configuration

Cross-platform ZSH configuration supporting **Debian**, **Ubuntu**, **Arch**, **Fedora**, and **macOS**.

The configuration automatically detects your OS and distro, then loads platform-specific tools and exports accordingly. All ZSH dotfiles and plugins live in `~/.config/zsh/` (configured via `$ZDOTDIR` in `.zshenv`).

## Key Features

- **Platform Detection**: Automatically detects OS/distro and configures appropriately
- **Multi-Machine Support**: Use `.zshrc.local` for machine-specific config (excluded from repo)
- **Completion Caching**: Daily refresh for faster shell startup
- **SSH Key Auto-Loading**: Automatically adds SSH keys on shell startup
- **PATH Deduplication**: Prevents duplicate PATH entries
- **Diagnostic Function**: Run `zsh_diagnose` to troubleshoot configuration

## Quick Start

### Setup

Use [stow](https://www.gnu.org/software/stow/) to symlink the config:

```bash
cd ~/dotfiles
stow zsh
```

This creates `~/.zshenv` → `dotfiles/zsh/.zshenv` and `~/.config/zsh` → `dotfiles/zsh/.config/zsh`.

### Clone Plugins

Plugins are not included in the repo. Clone them to their respective directories:

```bash
# Plugins (into .config/zsh/plugins/)
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ~/.config/zsh/plugins/fast-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.config/zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions.git ~/.config/zsh/plugins/zsh-completions

# Tools (into .config/zsh/tools/)
git clone https://github.com/junegunn/fzf-git.sh.git ~/.config/zsh/tools/fzf-git.sh
```

## Plugins

- [Fast Syntax Highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting) – Syntax highlighting as you type
- [ZSH Autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) – Command suggestions from history
- [ZSH Completions](https://github.com/zsh-users/zsh-completions) – Additional completion definitions
- [fzf-git](https://github.com/junegunn/fzf-git.sh) – Git integrations with fzf

## Prompt Theme

- [Starship](https://starship.rs/) – Fast, customizable, cross-platform prompt

Using a custom **"Dusk"** theme — a muted pastel powerline prompt with slanted separators. See the [starship config README](../starship/README.md) for details on the palette, segments, and font requirements.

Install starship:
```bash
curl -sS https://starship.rs/install.sh | sh
```

Symlink the config:
```bash
cd ~/path/to/dotfiles && stow starship
```

**Requires a Nerd Font** (e.g. `ttf-jetbrains-mono-nerd`) — see the [starship README](../starship/README.md#font-setup) for install commands and the [kitty README](../kitty/README.md#font) for terminal font setup.

## Core Command Line Tools

### Essential

| Tool | Purpose | Install |
|------|---------|---------|
| **neovim** | Text/code editor (aliased to `vim`) | [nvim.io](https://neovim.io/)<br/> Config: [Aapok0/nvim](https://github.com/Aapok0/nvim) |
| **eza** | Better `ls` for listing files | `pacman -S eza` / `apt install eza` / `brew install eza` |
| **bat** | Cat with syntax highlighting | `pacman -S bat` / `apt install bat` / `brew install bat` |
| **fzf** | Fuzzy finder for files/commands | `pacman -S fzf` / `apt install fzf` / `brew install fzf` |
| **fd** | Fast alternative to `find` | `pacman -S fd` / `apt install fd-find` / `brew install fd` |
| **zoxide** | Smarter directory navigation | `pacman -S zoxide` / See [zoxide.rs](https://zoxide.rs/) for other distros |
| **ripgrep** | Fast recursive grep with regex | `pacman -S ripgrep` / `apt install ripgrep` / `brew install ripgrep` |

### Additional

| Tool | Purpose | Install |
|------|---------|---------|
| **tmux** | Session/window/pane manager | `pacman -S tmux` / `apt install tmux` / `brew install tmux`<br/> Config: [Aapok0/tmux](https://github.com/Aapok0/tmux) |
| **thefuck** | Autocorrect mistyped commands | `pacman -S thefuck` / `pip install thefuck` / `brew install thefuck` |
| **tldr** | Quick command examples | `pacman -S tldr` / `npm install -g tldr` / `brew install tldr` |
| **btop/htop** | Resource/process monitoring | `pacman -S btop` / `apt install btop` / `brew install btop` |
| **xclip** | Clipboard management | `pacman -S xclip` / `apt install xclip` / (macOS has native support) |
| **entr** | Run commands when files change | `pacman -S entr` / `apt install entr` / `brew install entr` |

### Node.js & NVM

The configuration automatically detects your NVM installation:

**Debian/Ubuntu** (package manager):
```bash
sudo apt install nvm
```

**Arch/Fedora** (package manager):
```bash
pacman -S nvm      # Arch
dnf install nvm    # Fedora
```

**macOS or manual install** (nvm installer):
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
```

Then use NVM:
```bash
nvm list-remote
nvm install 20
nvm use 20
```

### Python Version Management (Optional)

**Pyenv** – Python version manager:

```bash
# Install
git clone https://github.com/pyenv/pyenv.git ~/.pyenv

# Use
pyenv install 3.11
pyenv local 3.11
```

Configuration auto-detects if `~/.pyenv` exists.

### Terraform Version Management (Optional)

**Tfswitch** – Terraform version switcher:

```bash
curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash
```

Installs to `~/bin/tfswitch`. Configuration auto-detects if `~/bin` exists.

## Machine-Specific Configuration

For settings specific to one machine (API keys, work paths, aliases), create `~/.config/zsh/.zshrc.local`:

```zsh
# ~/.config/zsh/.zshrc.local
# Example:

export MY_API_KEY="secret123"
export WORK_DIR="/mnt/work"

alias work='cd $WORK_DIR'
alias prod='ssh user@prod.example.com'

# Override tools for this machine
export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/docker.sock"
```

This file is **auto-loaded if it exists** and is in `.gitignore` (won't be committed).

## Diagnostics

Run this command to check your configuration:

```bash
zsh_diagnose
```

Output:
```
=== ZSH Configuration Diagnostics ===
OS: Linux | Distro: Arch
Installed tools:
  ✓ nvim
  ✓ docker
  ✓ fd
  ✓ fzf
  ✓ bat
  ✓ eza
  ✓ starship
  ✓ nvm
  ✗ pyenv
  ✗ tfswitch

PATH entries: 28
Config file size: 354 lines
Local config: ✓ loaded

Completion cache: ✓ clean
```

## SSH Keys

SSH keys are auto-loaded on shell startup (if they exist in `~/.ssh/`).

Supported key types: `id_ed25519`, `id_rsa`, `id_ecdsa`

### Setup SSH Keys

Generate a new key:
```bash
ssh-keygen -t ed25519 -C "your@email.com"
```

For convenience, remove the passphrase (recommended for personal dev machines):
```bash
ssh-keygen -p -f ~/.ssh/id_ed25519
# When prompted: leave "New passphrase" empty, then confirm
```

For production machines, keep the passphrase. You'll be prompted once per session.

## Aliases

| Alias | Command |
|-------|---------|
| `ls`, `ll`, `la` | eza-based file listing |
| `tree` | `eza -aT --icons` |
| `vim` | `nvim` |
| `python` | `python3` |
| `tmuxn` | Create named tmux session |
| `tmuxa` | Attach to tmux session |
| `tmuxnd` | Create session named after current dir |
| `tf` | `terraform` |
| `grep`, `fgrep`, `egrep` | Color-enabled versions |

## Platform-Specific Setup

### Debian/Ubuntu

Additional tools best installed via package manager:

```bash
sudo apt update
sudo apt install -y \
    eza bat fd-find fzf ripgrep zoxide \
    tmux thefuck tldr btop xclip entr
```

### Arch/Fedora

```bash
# Arch
pacman -S eza bat fd fzf ripgrep zoxide tmux thefuck tldr btop xclip entr nvm

# Fedora
dnf install eza bat fd fzf ripgrep zoxide tmux thefuck tldr btop xclip entr
```

### macOS

Install via Homebrew:

```bash
brew install eza bat fd fzf ripgrep zoxide tmux thefuck tldr btop xclip entr nvm starship
```

**Note**: macOS includes native clipboard support; `xclip` is optional.

## Configuration Structure

```
~/.config/zsh/
├── .zshrc              # Main configuration (this repo)
├── .zshrc.local        # Machine-specific (excluded from repo, optional)
├── .zsh_history        # History file (excluded from repo)
├── .zcompdump*         # Completion cache (excluded from repo)
├── .zshenv             # Environment setup (this repo)
├── plugins/            # Downloaded plugins (excluded from repo)
│   ├── fast-syntax-highlighting/
│   ├── zsh-autosuggestions/
│   └── zsh-completions/
└── tools/              # Downloaded tools (excluded from repo)
    └── fzf-git.sh/
```

## Troubleshooting

**Issue**: "command not found" for a tool
- Run `zsh_diagnose` to check if tools are installed
- Verify tool is in PATH: `echo $PATH`
- Check `.zshrc.local` isn't masking the PATH

**Issue**: Shell startup is slow
- Check completion cache: `zsh_diagnose`
- List loaded files: `set +x; source ~/.zshrc; set -x 2>&1 | head -20`

**Issue**: SSH keys not loading
- Check keys exist: `ls -la ~/.ssh/id_*`
- Manual test: `ssh-add ~/.ssh/id_ed25519`
- Check if you have passphrase set: `ssh-keygen -y -f ~/.ssh/id_ed25519`

**Issue**: Platform detection not working
- Check distro detection: `lsb_release -si` or `uname -s`
- Verify `.zshenv` is sourced: `echo $ZDOTDIR`
