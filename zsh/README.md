# ZSH configuration file

ZSH configuration I currently use. I keep .zshrc, .zsh_history and other zdotfiles and themes and plugins directory under ~/.config/zsh. For it to work I've had to define the history file path in .zshrc, redefine $ZDOTDIR in .zshenv and link .zshenv to home directory in the following way:

```bash
ln -sT ~/.config/zsh/.zshenv ~/.zshenv
```

Path in the beginning depends on the system you have. Plugins and themes need to be cloned from their Github repositories to themes and plugins directories before using them with the configuration. Same applies to the programs added to path at the end, which need to be installed.

## Themes and plugins

- [Spaceship prompt](https://github.com/spaceship-prompt/spaceship-prompt)
- [PowerLevel10k prompt (currently in use)](https://github.com/romkatv/powerlevel10k)
- [Fast Syntax Highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting)
- [ZSH Autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [ZSH Completions](https://github.com/zsh-users/zsh-completions)

## Core command line tools

### eza

Better ls to list directories and their contents. Aliased ls and tree to eza.

If using debian based distro, use following commands to install:

```bash
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza
```

### htop and btop

Better resource and process monitoring. Prefer btop currently.

### bat (batcat)

More featured cat command.

If using debian based distro, install newest release with .deb file from [here](https://github.com/sharkdp/bat/releases).

### neovim

Text/code editor I use. Config located [here](https://github.com/Aapok0/nvim). Aliased to vim.

### tmux

Session, window and pane manager. Config located [here](https://github.com/Aapok0/tmux).

### fzf

Fuzzy finder to look for files and commands more quickly. Easiest to install and configure from the source:

```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

### fd

Alternative for find, that provides sensible filters.

### zoxide

Tool to make moving between directories faster. It remembers your old cd commands and can query them so you can move around with just a keyword.

If using a debian based distro, install from source:

```bash
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
```

### ripgrep

Better recursive grep to current directory and subdirectories with regex pattern. Used in neovim telescope plugin.

### entr

Runs commands , if target file/s change. Good for programming and testing.

### xclip

Clipboard command line tool. I use it especially to copy paste with clipboard in neovim.

### tfswitch

Command line tool to install and switch between different versions of terraform. In debian based distros it can be installed with:

```bash
curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash
```

### NodeJS and npm

For everything javascript and dependency for many other tools. Installed with:

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

### tldr

Tool to show quick tips how to use common command line tools.

In debian based distros it's easiest to install with npm:

```bash
sudo npm install -g tldr
```

In mac use homebrew and install the rust client:

```bash
brew install tlrc
```

### thefuck

Tool to autocorrect a command you fucked up earlier.

In debian based distros it's easiest to install with pip:

```bash
pip install thefuck --user
```

Use homebrew on mac:

```bash
brew install thefuck
```

## Extra step for Mac

Dircolors don't exist in Mac be default, but they can be downloaded as part of coreutils:

```bash
brew install coreutils
```

Also add the following to .zshrc:

```bash
export PATH='/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH'
```
