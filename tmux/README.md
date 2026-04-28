# Tmux configuration

Configuration and plugins for tmux, managed with [TPM](https://github.com/tmux-plugins/tpm). Config is stored under `~/.config/tmux/`.

## Installation

### 1. Install TPM

```bash
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```

### 2. Install plugins

Open tmux and press `prefix + I` (capital I) to install all plugins listed in the config.

### 3. Dependencies

Some plugins and keybinds require external tools:

- [fzf](https://github.com/junegunn/fzf) — required by `tmux-fzf` and the `tmuxf` session script
- [zoxide](https://github.com/ajeetdsouza/zoxide) — required by the `tmuxf` / `tmuxz` session scripts
- [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) — must also be installed in Neovim/Vim for seamless pane navigation

## General settings

| Setting | Value | Description |
|---------|-------|-------------|
| `default-terminal` | `tmux-256color` | Correct terminal type for true color and undercurl |
| `terminal-overrides` | `xterm-256color:RGB` | Enable RGB color support |
| `mouse` | `on` | Full mouse support (scroll, click, resize, select) |
| `escape-time` | `5` | Near-instant escape key (avoids ghost characters vs 0) |
| `history-limit` | `50000` | Scrollback buffer lines |
| `focus-events` | `on` | Pass focus events to programs (needed for Neovim `autoread`) |
| `set-clipboard` | `on` | OSC 52 clipboard — works over SSH |
| `base-index` | `1` | Windows start at 1 |
| `pane-base-index` | `1` | Panes start at 1 |
| `renumber-windows` | `on` | Re-number windows when one is closed |
| `pane-border-lines` | `heavy` | Thicker pane borders for visibility |
| `mode-keys` | `vi` | Vi-style keys in copy mode |

## Keybindings

Prefix is **`Ctrl + Space`** (rebound from the default `Ctrl + b`).

### General

| Keybind | Action |
|---------|--------|
| `prefix + r` | Reload tmux config |
| `prefix + f` | Open `tmuxf` (fzf+zoxide session picker) in a new window |

### Pane navigation (no prefix needed)

| Keybind | Action |
|---------|--------|
| `Alt + ←` | Select pane left |
| `Alt + →` | Select pane right |
| `Alt + ↑` | Select pane up |
| `Alt + ↓` | Select pane down |
| `Ctrl + h/j/k/l` | Navigate panes (vim-tmux-navigator, works across Vim splits) |

### Pane management

| Keybind | Action |
|---------|--------|
| `prefix + "` | Split horizontally (keeps current path) |
| `prefix + %` | Split vertically (keeps current path) |
| `prefix + H` | Resize pane left by 5 cells (repeatable) |
| `prefix + J` | Resize pane down by 5 cells (repeatable) |
| `prefix + K` | Resize pane up by 5 cells (repeatable) |
| `prefix + L` | Resize pane right by 5 cells (repeatable) |

### Window navigation (no prefix needed)

| Keybind | Action |
|---------|--------|
| `Shift + ←` | Previous window |
| `Shift + →` | Next window |
| `Alt + H` | Previous window |
| `Alt + L` | Next window |

### Copy mode (vi-style)

Enter copy mode with `prefix + [`, then:

| Keybind | Action |
|---------|--------|
| `v` | Begin selection |
| `Ctrl + v` | Toggle rectangle selection |
| `y` | Yank (copy) selection and exit copy mode |

### Session management (tmux-sessionist)

| Keybind | Action |
|---------|--------|
| `prefix + g` | Switch to a session by name |
| `prefix + C` | Create a new session |
| `prefix + X` | Kill current session (switch to another) |
| `prefix + S` | Switch to last session |
| `prefix + @` | Promote current pane to a new session |

### tmux-fzf

| Keybind | Action |
|---------|--------|
| `prefix + F` (capital F) | Open tmux-fzf menu (sessions, windows, panes, commands, keybindings) |

### tmux-thumbs

| Keybind | Action |
|---------|--------|
| `prefix + Space` | Highlight copyable items (URLs, paths, hashes, IPs, etc.) then press the shown hint key to copy |

### tmux-logging

| Keybind | Action |
|---------|--------|
| `prefix + Shift + p` | Toggle logging of current pane to a file |
| `prefix + Alt + p` | Save visible pane contents ("screen capture") |
| `prefix + Alt + Shift + p` | Save complete pane history to a file |

### tmux-yank

In copy mode, standard `y` copies to system clipboard. Additionally:

| Keybind | Action |
|---------|--------|
| `prefix + y` | Copy current command line to clipboard |
| `prefix + Y` | Copy current pane's working directory to clipboard |

## Plugins

| Plugin | Description |
|--------|-------------|
| [tpm](https://github.com/tmux-plugins/tpm) | Tmux Plugin Manager |
| [tmux-sensible](https://github.com/tmux-plugins/tmux-sensible) | Sensible default options (utf-8, history, key repeat, etc.) |
| [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) | Seamless `Ctrl + h/j/k/l` navigation between tmux panes and Vim splits |
| [catppuccin/tmux](https://github.com/catppuccin/tmux) | Catppuccin color theme (v2, `macchiato` flavor) |
| [tmux-yank](https://github.com/tmux-plugins/tmux-yank) | System clipboard integration for copy mode |
| [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect) | Save and restore sessions (windows, panes, layouts) across restarts |
| [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum) | Automatic save (every 15 min) and auto-restore on tmux server start |
| [tmux-sessionist](https://github.com/tmux-plugins/tmux-sessionist) | Lightweight session management keybinds |
| [tmux-fzf](https://github.com/sainnhe/tmux-fzf) | Fzf-powered switching for sessions, windows, panes, and commands |
| [tmux-thumbs](https://github.com/fcsonline/tmux-thumbs) | Quick-copy highlighted patterns (URLs, paths, hashes, IPs) from the terminal |
| [tmux-logging](https://github.com/tmux-plugins/tmux-logging) | Log pane output, screen capture, and full history dump to files |

## Session helper scripts

The companion `tmux-tools` package provides two scripts that use [zoxide](https://github.com/ajeetdsouza/zoxide) for smart session management. Both should be in your `$PATH`.

### `tmuxf`

Interactive session picker. Opens zoxide's fzf interface, then creates or switches to a tmux session named after the selected directory. Bound to `prefix + f`.

### `tmuxz <query>`

Non-interactive version. Pass a zoxide query (e.g. `tmuxz dotfiles`) and it will resolve the path, confirm, then create or attach to the session. Useful from outside tmux or from scripts.

## Plugin management

| Action | Command |
|--------|---------|
| Install plugins | `prefix + I` |
| Update plugins | `prefix + U` |
| Remove unlisted plugins | `prefix + Alt + u` |
