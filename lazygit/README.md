# Lazygit Configuration

Terminal UI for git with Catppuccin Mocha theme, delta pager, and Nerd Font icons.

## Config Overview

| Setting | Value |
|---|---|
| Theme | Catppuccin Mocha |
| Icons | Nerd Font v3 |
| Pager | [delta](https://github.com/dandavtella/delta) (syntax-highlighted diffs) |
| Editor | neovim (`nvim`) |
| Border | Rounded |
| Auto fetch | Enabled |
| GPG override | Disabled (uses your gitconfig GPG settings) |

## Install

```bash
# macOS
brew install lazygit

# Arch
sudo pacman -S lazygit

# Fedora (COPR)
sudo dnf copr enable atim/lazygit -y && sudo dnf install lazygit

# Debian
go install github.com/jesseduffield/lazygit@latest
```

## Setup

```bash
cd ~/dotfiles
stow lazygit
```

This symlinks `~/.config/lazygit/config.yml`.

## Usage

Launch from any git repo:

```bash
lazygit
```

### Key Panels

| Key | Panel |
|---|---|
| `1` | Status |
| `2` | Files (stage/unstage) |
| `3` | Branches |
| `4` | Commits |
| `5` | Stash |

### Common Actions

| Key | Action |
|---|---|
| `Space` | Stage/unstage file |
| `a` | Stage all |
| `c` | Commit |
| `C` | Commit with editor |
| `p` | Push |
| `P` | Pull |
| `Enter` | View file diff / expand |
| `e` | Edit file in nvim |
| `/` | Search |
| `?` | Help |
| `q` | Quit |

## Requirements

- [delta](https://github.com/dandavtella/delta) — used as the diff pager
- A **Nerd Font** (e.g. JetBrainsMono) — for file/branch icons
