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

## Configurations

These are short introductions and requirements. More info can be found in the readmes of the subdirectories.

### bat

A cat replacement with syntax highlighting.

### dunst

A notification daemon I use with i3.

### gitconfig

Configuration file for git.

#### Requirements

- git-delta

### i3

A window manager I use instead of a desktop environment.

#### Requirements

Tools and apps:

- kitty
- firefox
- thunar
- amixer
- playerctl
- scrot
- polkit-gnome
- dex
- feh
- xset
- xrandr
- arandr
- dunst
- picom
- i3blocks
- lightdm
- gtk2
- gtk3
- gtk4
- rofi
- rofi-greenclip
- autotiling

Autostart apps:

- any bluetooth app
  - for example blueberry
- any network app
  - for example nm-applet

Themes and icons:
- gnome-themes-extra
- catppuccin-gtk-theme-mocha
- qogir-gtk-theme
- qogir-icon-theme

Fonts:

- MesloLGS NF
- FiraMono Nerd Font

Directories:

- ~/Screenshots

### kitty

A fast gpu accelerated terminal emulator.

#### Requirements

Font:

- MesloLGS NF (with linux)
- Fira Code Nerd Font (with MacOS)

### nvim

Text editor I use for everything including programming.

#### Requirements

At least version 0.8

Tools:

- xclip
- xsel
- ripgrep
- npm (node)
- python

### picom

A compositor for X11. Used with i3 for some visual enhancements.

### rofi

A window application used to replace dmenu in i3.

### skhd

Keybinding tool for MacOS used to make keybindings for Yabai.

### tmux

Terminal multiplexer that I use to create multiple sessions for different contexts.

#### Requirements

- tmux plugin manager (tpm)
  - clone it to `~/tmux/plugins/tpm`

### tmux-tools

Two scripts for creating tmux session based on a directory name found either with zoxide or fzf.

#### Requirements

- tmux
- zoxide
- fzf
- bash

### vim

A great text editor. I prefer to use the newer fork of it neovim, but also have configurations for this one.

### yabai

A window manager for MacOS.

### zsh

An extended bourne shell with many improvements. I use it instead of bash.

#### Requirements

Plugins:

- Fast Syntax Highlighting
- ZSH Autosuggestions
- ZSH Completions

Prompt themes (choose one):

- Spaceship
  - Need to comment powerlevel10k lines and uncomment spaceship lines in .zshrc for this one.
- Powerlevel10k

Tools:

- dircolors
- eza
- bat
- neovim
- tmux
- fzf
- zoxide
- fd
- tfswitch
- nvm
- pnpm
- python3
- pipx
- flyctl
- thefuck

Mac specific:
- coreutils
  - Also need to add the path to .zshrc
