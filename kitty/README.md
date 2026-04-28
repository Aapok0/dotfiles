# Kitty configuration

Terminal emulator configuration for [Kitty](https://sw.kovidgoyal.net/kitty/).

## Setup

1. Install Kitty
2. Symlink or copy the config: `ln -s /path/to/dotfiles/kitty/.config/kitty ~/.config/kitty`
3. Install the font (see below)
4. Install a color scheme (optional — `colors.conf` is included via [Gogh](https://gogh-co.github.io/Gogh/))

### Install Kitty

```bash
# Debian/Ubuntu
sudo apt-get install kitty

# Fedora
sudo dnf install kitty

# Arch
sudo pacman -S kitty

# macOS
brew install --cask kitty
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
| Font | JetBrainsMono Nerd Font, 11pt |
| Color scheme | Loaded from `colors.conf` (Gogh) |
| Background opacity | 0.88 (slight transparency) |
| Layout | Tall (50/50 split) |
| Tab bar | Top, powerline slanted style |
| Editor | Neovim |
| macOS Option key | Passed as Alt (for Neovim Meta keybindings) |
