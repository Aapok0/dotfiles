# Atuin Configuration

SQLite-backed shell history with fuzzy search, replacing the default fzf `Ctrl+R` binding.

## Features

| Setting | Value |
|---|---|
| Search mode | `fuzzy` (also supports `prefix`, `substring`) |
| Filter mode | `global` (search all history, not just current session/directory) |
| UI style | `full` (always shows preview pane) |
| Preview | Enabled — shows full command text for long/multi-line commands |
| Up arrow | Normal shell behavior (atuin only on `Ctrl+R`) |
| Secrets filter | Enabled — ignores commands starting with a space |
| Failed commands | Stored |
| Sync | Disabled (can be enabled for cross-machine sync) |

### Filtered Commands

Short/trivial commands are excluded from history: `cd`, `ls`, `ll`, `exit`, `clear`, `pwd`.

## Install

```bash
# macOS
brew install atuin

# Arch
sudo pacman -S atuin

# Fedora (COPR)
sudo dnf install atuin

# Debian/Ubuntu
bash <(curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh)
```

## Setup

```bash
cd ~/dotfiles
stow atuin
```

If atuin auto-created `~/.config/atuin/` before stowing, remove it first:

```bash
rm -rf ~/.config/atuin && stow atuin
```

### Import Existing History

```bash
# Recommended
just atuin-import

# Or manually
atuin import auto
```

### Shell Integration

The zsh config ([zsh/.config/zsh/.zshrc](../zsh/.config/zsh/.zshrc)) initializes atuin with up-arrow disabled:

```zsh
eval "$(atuin init zsh --disable-up-arrow)"
```

- **Ctrl+R** — opens atuin fuzzy search
- **Up/Down arrows** — normal shell history navigation

## Usage

| Key | Action |
|---|---|
| `Ctrl+R` | Open interactive search |
| `Enter` | Accept selected command |
| `Tab` | Edit selected command before running |
| `Ctrl+O` | Open inspector (timestamp, duration, exit code) |
| `Esc` | Exit search |

### Search Modes

Cycle search modes with `Ctrl+R` while in the search UI:

- **fuzzy** — matches characters in any order
- **prefix** — matches from the start
- **substring** — exact substring match

### Filter Modes

Cycle filter scope with `Ctrl+S` while in the search UI:

- **global** — all history
- **host** — current machine only
- **session** — current shell session
- **directory** — current working directory

## Troubleshooting

**Atuin not activating**: Ensure `HISTFILE` is exported (`env | grep HISTFILE`). Run `exec zsh` to reload.

**No history after install**: Run `atuin import auto` to import from your shell history file.

**Preview not visible**: Ensure `style = "full"` in config. With `auto` or `compact`, the preview may be hidden.
