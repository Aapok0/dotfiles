# Ghostty configuration

Terminal emulator configuration for [Ghostty](https://ghostty.org/).

## Setup

1. Install Ghostty
2. Symlink or copy the config: `ln -s /path/to/dotfiles/ghostty/.config/ghostty ~/.config/ghostty`
3. Install the font (see below)

### Install Ghostty

```bash
# macOS
brew install --cask ghostty

# Arch (official repos)
sudo pacman -S ghostty

# Fedora (COPR — not in official repos)
sudo dnf copr enable scottames/ghostty
sudo dnf install ghostty

# Debian (community repo — not in official repos)
# See https://ghostty.org/docs/install/binary#debian
# linux-setup setup-debian enables debian.griffo.io automatically
```

## Font

Uses **JetBrainsMono Nerd Font** — includes ligatures, powerline symbols, and devicons.

### macOS

```bash
brew install --cask font-jetbrains-mono-nerd-font
```

### Arch

```bash
sudo pacman -S ttf-jetbrains-mono-nerd
```

### Fedora

```bash
sudo dnf install jetbrains-mono-fonts-all
# Nerd Font patched version (via COPR or manual download):
# https://www.nerdfonts.com/font-downloads
```

### Debian

```bash
# Download from https://www.nerdfonts.com/font-downloads
mkdir -p ~/.local/share/fonts
unzip JetBrainsMono.zip -d ~/.local/share/fonts/
fc-cache -fv
fc-list | grep JetBrains
```

## Configuration overview

| Setting | Value |
|---|---|
| Font | JetBrainsMono Nerd Font, 10pt |
| Color scheme | Catppuccin Mocha (built-in) |
| Background opacity | 0.88 (with blur at intensity 20) |
| Cursor | Blinking bar |
| macOS Option key | Left = Alt |
| Scrollback | 50,000 lines |
| Window state | Saved and restored across restarts |
| Working directory | Inherited by new windows |
| Unfocused split opacity | 0.85 |
| URL detection | Enabled |
