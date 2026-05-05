# ZSH Configuration

Cross-platform ZSH configuration supporting **Debian**, **Arch**, **Fedora**, and **macOS**.

The configuration automatically detects your OS and distro, then loads platform-specific tools and exports accordingly. All ZSH dotfiles and plugins live in `~/.config/zsh/` (configured via `$ZDOTDIR` in `.zshenv`).

## Key Features

- **Platform Detection**: Automatically detects OS/distro and configures appropriately
- **Atuin History**: SQLite-backed shell history with fuzzy, directory-scoped search (replaces fzf Ctrl+R)
- **Multi-Machine Support**: Use `.zshrc.local` for machine-specific config (excluded from repo)
- **Completion Caching**: Daily refresh for faster shell startup
- **SSH Key Auto-Loading**: Automatically adds SSH keys on shell startup
- **PATH Deduplication**: Prevents duplicate PATH entries
- **Diagnostic Function**: Run `zsh_diagnose` to troubleshoot configuration

## Quick Start

### Setup

Use [stow](https://www.gnu.org/software/stow/) to symlink the config (or use `just stow zsh` from the repo root):

```bash
cd ~/dotfiles
stow zsh
```

This creates `~/.zshenv` → `dotfiles/zsh/.zshenv` and `~/.config/zsh` → `dotfiles/zsh/.config/zsh`.

If zsh isn't your default shell yet:

```bash
just set-shell
```

### Clone Plugins

Plugins are not included in the repo. Clone them using the just recipe (or manually):

```bash
# Recommended — skips already-cloned plugins
just zsh-plugins

# Or clone manually
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ~/.config/zsh/plugins/fast-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.config/zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions.git ~/.config/zsh/plugins/zsh-completions
git clone https://github.com/junegunn/fzf-git.sh.git ~/.config/zsh/tools/fzf-git.sh
```

## Plugins

| Plugin | Purpose |
|---|---|
| [Fast Syntax Highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting) | Syntax highlighting as you type |
| [ZSH Autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | Command suggestions from history (powered by atuin when available) |
| [ZSH Completions](https://github.com/zsh-users/zsh-completions) | Additional completion definitions |
| [fzf-git](https://github.com/junegunn/fzf-git.sh) | Git integrations with fzf |

## Prompt

Uses [Starship](https://starship.rs/) with a custom **"Dusk"** theme — muted pastel powerline with slanted separators. See the [starship README](../starship/README.md) for details.

Requires a **Nerd Font** (e.g. JetBrainsMono Nerd Font) — see the [root README](../README.md#font) for install commands.

## Core Tools

These tools are integrated into the zsh config and expected to be installed. On macOS, all of these are included in the [Brewfile](../Brewfile). On Linux, use `just apt-install`, `just pacman-install`, or `just dnf-install` from the repo root for core packages.

### Essential

| Tool | Purpose |
|---|---|
| [neovim](https://neovim.io/) | Editor (aliased to `vim`) — config: [nvim](../nvim/) |
| [eza](https://github.com/eza-community/eza) | Modern `ls` replacement |
| [bat](https://github.com/sharkdp/bat) | `cat` with syntax highlighting |
| [fzf](https://github.com/junegunn/fzf) | Fuzzy finder (files, dirs, completions) |
| [fd](https://github.com/sharkdp/fd) | Fast `find` replacement |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | Smart `cd` with frecency |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | Fast recursive grep |
| [git-delta](https://github.com/dandavtella/delta) | Syntax-highlighted git diffs |
| [starship](https://starship.rs/) | Cross-shell prompt |
| [atuin](https://github.com/atuinsh/atuin) | Shell history search (replaces fzf Ctrl+R) |

### Additional

| Tool | Purpose |
|---|---|
| [tmux](https://github.com/tmux/tmux) | Terminal multiplexer — config: [tmux](../tmux/) |
| [thefuck](https://github.com/nvbn/thefuck) | Command autocorrection |
| [tldr](https://github.com/tldr-pages/tldr) | Simplified man pages |
| [btop](https://github.com/aristocratos/btop) | System monitor |
| [direnv](https://github.com/direnv/direnv) | Per-directory environment variables |
| [xclip](https://github.com/astrand/xclip) | Clipboard management (Linux only, macOS has native support) |
| [entr](https://github.com/eradman/entr) | Run commands when files change |

### Node.js & NVM

The configuration automatically detects your NVM installation:

```bash
# Debian
sudo apt install nvm

# Arch / Fedora
sudo pacman -S nvm      # Arch
sudo dnf install nvm    # Fedora

# macOS or manual install
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
```

### Python Version Management (Optional)

[Pyenv](https://github.com/pyenv/pyenv) is auto-detected if `~/.pyenv` exists:

```bash
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
pyenv install 3.11
pyenv local 3.11
```

### Terraform Version Management (Optional)

[Tfswitch](https://github.com/warrensbox/terraform-switcher) is auto-detected if `~/bin` exists:

```bash
curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash
```

## Aliases

| Alias | Command |
|---|---|
| `ls`, `ll`, `la` | eza-based file listing |
| `tree` | `eza -aT --icons` |
| `vim` | `nvim` |
| `python` | `python3` |
| `tmuxn` | Create named tmux session |
| `tmuxa` | Attach to tmux session |
| `tmuxnd` | Create session named after current dir |
| `tf` | `terraform` |
| `grep`, `fgrep`, `egrep` | Color-enabled versions |

## Machine-Specific Configuration

For settings specific to one machine (API keys, work paths, aliases), create `~/.config/zsh/.zshrc.local`:

```zsh
export MY_API_KEY="secret123"
alias work='cd ~/projects/work'
export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/docker.sock"
```

This file is **auto-loaded if it exists** and is not tracked by git.

## SSH Keys

SSH keys are auto-loaded on shell startup (if they exist in `~/.ssh/`).

Supported key types: `id_ed25519`, `id_rsa`, `id_ecdsa`

Generate a new key:
```bash
ssh-keygen -t ed25519 -C "your@email.com"
```

To remove passphrase (personal dev machines only):
```bash
ssh-keygen -p -f ~/.ssh/id_ed25519
```

## Configuration Structure

```
~/.config/zsh/
├── .zshrc              # Main configuration (this repo)
├── .zshrc.local        # Machine-specific (not tracked, optional)
├── .zsh_history        # History file (not tracked)
├── .zcompdump*         # Completion cache (not tracked)
├── .zshenv             # Environment setup (this repo)
├── plugins/            # Downloaded plugins (not tracked)
│   ├── fast-syntax-highlighting/
│   ├── zsh-autosuggestions/
│   └── zsh-completions/
└── tools/              # Downloaded tools (not tracked)
    └── fzf-git.sh/
```

## Diagnostics

```bash
zsh_diagnose
```

```
=== ZSH Configuration Diagnostics ===
OS: Linux | Distro: Arch
Installed tools:
  ✓ nvim    ✓ docker    ✓ fd    ✓ fzf
  ✓ bat     ✓ eza       ✓ starship
  ✓ nvm    ✗ pyenv     ✗ tfswitch
```

## Troubleshooting

**"command not found" for a tool**: Run `zsh_diagnose` to check installed tools. Verify PATH with `echo $PATH`.

**Shell startup is slow**: Check completion cache with `zsh_diagnose`. Try `time zsh -ic exit` to measure.

**SSH keys not loading**: Check keys exist with `ls -la ~/.ssh/id_*`. Test manually with `ssh-add ~/.ssh/id_ed25519`.

**Atuin not working**: Ensure `HISTFILE` is exported (`env | grep HISTFILE`). Run `exec zsh` to reload, then `atuin import auto` to import existing history.

**Platform detection not working**: Check `lsb_release -si` or `uname -s`. Verify `echo $ZDOTDIR` points to `~/.config/zsh`.
