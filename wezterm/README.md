# WezTerm configuration

Terminal emulator configuration for [WezTerm](https://wezfurlong.org/wezterm/).

## Setup

1. Install WezTerm
2. Symlink or copy the config: `ln -s /path/to/dotfiles/wezterm/.config/wezterm ~/.config/wezterm`
3. Install the font (see below)

### Install WezTerm

```bash
# macOS
brew install --cask wezterm

# Arch
sudo pacman -S wezterm

# Debian/Ubuntu — via official repo
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo apt update && sudo apt install wezterm

# Fedora (COPR)
sudo dnf copr enable wezfurlong/wezterm-nightly
sudo dnf install wezterm
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
fc-cache -fv
fc-list | grep JetBrains
```

## Configuration overview

| Setting | Value |
|---|---|
| Font | JetBrainsMono Nerd Font, 11pt |
| Color scheme | Catppuccin Mocha (built-in) |
| Background opacity | 0.88 (with macOS blur) |
| Window decorations | Integrated buttons + resize |
| Tab bar | Top, always visible, fancy style |
| Cursor | Blinking bar |
| macOS Option key | Left = Alt, Right = compose |
| Scrollback | 50,000 lines |
| Renderer | WebGPU (high performance) |
| Inactive pane dimming | 70% brightness, 85% saturation |
| macOS Option key | Left = Alt, Right = compose |
| Scrollback | 50,000 lines |
