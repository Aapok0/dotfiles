# Yazi Configuration

Terminal file manager with image previews, Catppuccin Mocha theme, and Nerd Font icons.

## Config Overview

| Setting | Value |
|---|---|
| Theme | Catppuccin Mocha (via `ya pkg`) |
| Layout ratio | 1:4:3 (parent : current : preview) |
| Sorting | Natural, case-insensitive, directories first |
| Hidden files | Shown by default |
| Editor | `$EDITOR` (falls back to nvim) |
| Image previews | Enabled (triangle filter, 75% quality) |

## Install

```bash
# macOS
brew install yazi

# Arch
sudo pacman -S yazi

# Fedora
sudo dnf install yazi

# Debian
cargo install --locked yazi-fm yazi-cli
```

## Setup

```bash
cd ~/dotfiles
stow yazi
```

Install the Catppuccin Mocha flavor (or use `just yazi-theme` from the repo root):

```bash
ya pkg install   # from package.toml lockfile
# or first-time add:
ya pkg add yazi-rs/flavors:catppuccin-mocha
```

Downloaded flavors live in `flavors/` and are **gitignored**; commit `package.toml` only.

## Usage

Launch:

```bash
yazi
```

### Navigation

| Key | Action |
|---|---|
| `h` / `l` | Parent dir / Enter dir |
| `j` / `k` | Move down / up |
| `J` / `K` | Page down / up |
| `g g` | Go to top |
| `G` | Go to bottom |
| `~` | Go to home |

### File Operations

| Key | Action |
|---|---|
| `Enter` | Open file (editor for text, `open`/`xdg-open` for others) |
| `e` | Edit in `$EDITOR` |
| `y` | Yank (copy) |
| `x` | Cut |
| `p` | Paste |
| `d` | Trash |
| `D` | Permanent delete |
| `a` | Create file |
| `r` | Rename |
| `Space` | Toggle selection |
| `.` | Toggle hidden files |

### Search & Filter

| Key | Action |
|---|---|
| `/` | Search in current dir |
| `f` | Filter current dir |
| `z` | Jump with zoxide |
| `Z` | Jump with fzf |
| `s` | Search files with fd |
| `S` | Search contents with rg |

## Files

| File | Purpose |
|---|---|
| `yazi.toml` | Manager, preview, opener, and task settings |
| `theme.toml` | Activates Catppuccin Mocha flavor |

## Requirements

- A **Nerd Font** for icons
- [fd](https://github.com/sharkdp/fd), [ripgrep](https://github.com/BurntSushi/ripgrep), [fzf](https://github.com/junegunn/fzf), [zoxide](https://github.com/ajeetdsouza/zoxide) — for search/jump features

```bash
# macOS (included in Brewfile)
brew install fd ripgrep fzf zoxide

# Arch
sudo pacman -S fd ripgrep fzf zoxide

# Fedora
sudo dnf install fd-find ripgrep fzf zoxide

# Debian
sudo apt install fd-find ripgrep fzf zoxide
```

### Optional (image preview & archive support)

These enable image thumbnails, PDF preview, video thumbnails, and archive extraction:

```bash
# macOS (included in Brewfile)
brew install ffmpeg sevenzip jq poppler

# Arch
sudo pacman -S ffmpeg p7zip jq poppler

# Fedora
sudo dnf install ffmpeg-free p7zip jq poppler-utils

# Debian
sudo apt install ffmpeg p7zip-full jq poppler-utils
```
