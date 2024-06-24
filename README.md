# Dotfiles

These are all my configuration files I use with CLI tools in Linux and MacOS. The configs can be added to home directory and with GNU stow.

## Setup

### 1. Install stow, if you haven't already:

#### Debian based distros

```bash
sudo apt install stow
```

#### Arch based distros

```bash
sudo pacman -S stow
```

#### MacOS

```
brew install stow
```

### 2. Use stow to symlink configuration files and directories (in the dotfiles directory):

#### Selected configurations

```bash
stow -vRt $HOME <directory-name-here>
```

#### All configurations
```bash
stow -vRt $HOME */
```

### 3. Delete configurations as needed (in the dotfiles directory):

#### Selected configurations

```bash
stow -vDt $HOME <directory-name-here>
```

#### All configurations
```bash
stow -vDt $HOME */
```
