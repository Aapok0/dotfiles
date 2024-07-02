# Neovim configurations with lua

The configurations and plugins I use currently. Packer is used as the package manager and the plugins.lua file installs it automatically.

## Required dependencies

Neovim requires a third-party program to use the system clipboard. I use the the following:

```bash
# Debian
sudo apt-get install xclip xsel

# Arch
sudo pacman -S xclip xsel

# Mac
brew install xclip xsel
```

Telescope plugin's live grep requires ripgrep:

```bash
# Debian
sudo apt-get install ripgrep

# Arch
sudo pacman -S ripgrep

# Mac
brew install ripgrep
```

NPM required for some LSP servers:

```bash
# Debian (adding nodesource)
curl -sL https://deb.nodesource.com/setup_20.x | sudo bash -
sudo apt-install nodejs

# Arch
sudo pacman -S node

# Linux/Mac (using nvm -> URL will change with new releases)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
source ~/.config/zsh/.zshrc
nvm list-remote
nvm install <version>

# Mac
brew install node
```

Python required for some LSP servers:

```bash
# Debian
sudo apt-install python3

# Arch
sudo pacman -S python

# Mac
brew install python3
```

## Possible issues

Some configurations like keymappings and plugins like Nvim Tree might not work with versions of Neovim below 0.8. In Debian based distros you can install latest unstable version with the following commands (more stable versions can be installed directly from source):

```bash
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install neovim
```
