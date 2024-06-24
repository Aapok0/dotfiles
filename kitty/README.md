# Kitty configuration

The configurations I use for the terminal emulator Kitty.

## Font

Install fonts according to OS and font:

### Fira Code Nerd Font Mono

- Works better in Mac than Meslo.

Linux installation:

```bash
# Download from https://www.nerdfonts.com/font-downloads
mv /path/to/downloaded/fonts /usr/share/fonts

# Install fontconfig, if you don't have it yet
sudo apt install fontconfig

# Update font cache
fc-cache -fv

# Verify the font is found
fc-list | grep Fira
```

Mac installation:

```bash
# Tap font casks with homebrew
brew tap homebrew/cask-fonts

# Install font with homebrew
brew install --cask font-fira-code-nerd-font
```

### Meslo Nerd Font patched for Powerlevel10k

- Currently using in Linux machine.

Linux installation:

```bash
# Download from https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#meslo-nerd-font-patched-for-powerlevel10k
mv /path/to/downloaded/fonts /usr/share/fonts

# Install fontconfig, if you don't have it yet
sudo apt install fontconfig

# Update font cache
fc-cache -fv

# Verify the font is found
fc-list | grep Meslo
```

Mac installation:

```bash
# Tap font casks with homebrew
brew tap homebrew/cask-fonts

# Install font with homebrew
brew install --cask font-meslo-for-powerlevel10k
```
