# Neovim configurations with lua

The configurations and plugins I use currently. Packer is used as the package manager and the plugins.lua file installs it automatically.

## Required dependencies

Neovim requires a third-party program to use the system clipboard. I use the the following:

```bash
# Linux
sudo apt-get install xclip

# Mac
brew install xclip
```

Telescope plugin's live grep requires ripgrep:

```bash
# Linux
sudo apt-get install ripgrep

# Mac
brew install ripgrep
```

NPM required for some LSP servers:

```bash
# Linux (adding nodesource)
curl -sL https://deb.nodesource.com/setup_20.x | sudo bash -
sudo apt-install nodejs

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
# Linux
sudo apt-install python3

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
