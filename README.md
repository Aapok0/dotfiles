# Dotfiles

Configuration files for CLI tools and development environments on Linux and macOS, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Quick Start

### Full install (recommended)

```bash
# Install prerequisites
# macOS:
brew install stow just
# Arch:
sudo pacman -S stow just
# Fedora:
sudo dnf install stow just
# Debian:
sudo apt-get install stow just

mkdir $HOME/Workspace
git clone <repo-url> $HOME/Workspace/dotfiles
cd $HOME/Workspace/dotfiles

# One command: installs packages, stows configs, clones plugins, sets up themes
just install
```

This auto-detects your OS and runs the appropriate package manager (including linters/formatters via `lint-tools`), then stows all configs, clones ZSH plugins and personal tools, installs TPM, the yazi theme, and imports shell history into atuin.

### Manual / step-by-step

```bash
just pacman-install        # or apt-install / dnf-install / brew-install
just tfswitch-install      # Linux — pinned binary; macOS: via Brewfile
just font-install
just stow-all              # symlink all configs
just zsh-plugins           # sync pinned ZSH plugins
just tools-clone           # clone personal shell tools (~/Workspace/tools)
just tpm-install           # sync TPM + tmux plugins
just set-shell             # change default shell to zsh
just yazi-theme            # install yazi Catppuccin theme
just atuin-import          # import shell history into atuin
just check                 # verify core tools are installed
```

`pacman-install`, `apt-install`, and `dnf-install` each call `lint-tools` at the end ([Linters & formatters](#linters--formatters)). Pinned binaries reinstall when Renovate bumps their version in the justfile.

After install, open tmux and press `prefix + I` to install tmux plugins, then `exec zsh` to reload your shell.

### Stow individual configs

```bash
just stow nvim
just stow zsh
just terminal=ghostty stow-all   # override default terminal
```

## Task Runner

A [justfile](justfile) automates common operations:

| Command | Description |
|---|---|
| `just install` | **Full setup** — packages, linters, stow, plugins, themes (auto-detects OS) |
| `just stow-all` | Stow all configs (uses default terminal) |
| `just unstow-all` | Remove all symlinks |
| `just restow-all` | Re-stow all (after adding new files) |
| `just stow <name>` | Stow a single config |
| `just unstow <name>` | Unstow a single config |
| `just font-install` | Install JetBrainsMono Nerd Font (auto-detects OS) |
| `just brew-install` | Install macOS deps via Brewfile |
| `just apt-install` | Install core deps + `lint-tools` (Debian) |
| `just pacman-install` | Install core deps + `lint-tools` (Arch) |
| `just dnf-install` | Install core deps + `lint-tools` (Fedora) |
| `just lint-tools` | Linters/formatters only (also run by the `*-install` recipes) |
| `just tfswitch-install` | Install Terraform version manager (Linux; macOS via Brewfile) |
| `just zsh-plugins` | Sync pinned ZSH plugins and fzf-git.sh |
| `just tools-clone` | Clone [personal tools](https://github.com/Aapok0/tools) to `~/Workspace/tools` |
| `just tpm-install` | Sync TPM for tmux, then install tmux plugins |
| `just set-shell` | Set default shell to zsh (no-op if already zsh) |
| `just yazi-theme` | Install yazi Catppuccin theme |
| `just atuin-import` | Import shell history into atuin |
| `just check` | Verify all core tools are installed |

Override the default terminal emulator with `just terminal=ghostty <command>`.

## Configurations

### Shell & Prompt

| Config | Description |
|---|---|
| [zsh](zsh/) | Cross-platform ZSH config with OS detection, fzf, atuin history, zoxide, completions, SSH key auto-loading |
| [starship](starship/) | Custom "Dusk" prompt theme — muted pastel powerline with Catppuccin-inspired palette |

### Terminal Emulators

One terminal is stowed by default (configurable via `just terminal=<name>`).

| Config | Description |
|---|---|
| [kitty](kitty/) | GPU-accelerated terminal with Catppuccin Mocha colors, powerline tabs, transparency (optional; default is ghostty) |
| [wezterm](wezterm/) | Lua-configurable terminal with built-in multiplexing, WebGPU rendering, integrated titlebar (optional; default is ghostty) |
| [ghostty](ghostty/) | Native-rendering terminal by Mitchell Hashimoto, minimal config, background blur |

All three use **JetBrainsMono Nerd Font** and **Catppuccin Mocha** theme.

### Editor

| Config | Description |
|---|---|
| [nvim](nvim/) | Modern Neovim in Lua — Lazy.nvim, Mason, LSP, Treesitter, Copilot, conform + nvim-lint |
| [vim](vim/) | Legacy Vim config with Vundle (Neovim preferred) |

### Git

| Config | Description |
|---|---|
| [gitconfig](gitconfig/) | Histogram diffs, delta integration, 20+ aliases, auto-upstream, SSH auth |

Requires [git-delta](https://github.com/dandavtella/delta). Create credentials at `~/.config/git/config.local`.

### Terminal Multiplexer

| Config | Description |
|---|---|
| [tmux](tmux/) | Prefix `Ctrl+Space`, vim-aware pane nav, Catppuccin theme, resurrect + continuum |
| [tmux-tools](tmux-tools/) | `tmuxz` and `tmuxf` — create/attach sessions via zoxide + fzf |

### TUI Tools

| Config | Description |
|---|---|
| [lazygit](lazygit/) | Git TUI with Catppuccin Mocha theme, delta pager, Nerd Font icons |
| [yazi](yazi/) | Terminal file manager with Catppuccin Mocha flavor, image preview |
| [atuin](atuin/) | SQLite-backed shell history — fuzzy search, directory-scoped, replaces fzf Ctrl+R |

### Other

| Config | Description |
|---|---|
| [bat](bat/) | `cat` replacement with syntax highlighting, Catppuccin Mocha theme |

## Core Tools

These tools are integrated into the ZSH config and expected to be installed:

### Essential

| Tool | Purpose |
|---|---|
| [neovim](https://neovim.io/) | Editor (aliased to `vim`) |
| [eza](https://github.com/eza-community/eza) | Modern `ls` replacement |
| [bat](https://github.com/sharkdp/bat) | `cat` with syntax highlighting |
| [fzf](https://github.com/junegunn/fzf) | Fuzzy finder (files, dirs, completions) |
| [fd](https://github.com/sharkdp/fd) | Fast `find` replacement |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | Smart `cd` with frecency |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | Fast recursive grep |
| [git-delta](https://github.com/dandavtella/delta) | Syntax-highlighted git diffs |
| [starship](https://starship.rs/) | Cross-shell prompt |
| [atuin](https://github.com/atuinsh/atuin) | Shell history search |

### TUI Applications

| Tool | Purpose |
|---|---|
| [lazygit](https://github.com/jesseduffield/lazygit) | Git TUI client |
| [lazydocker](https://github.com/jesseduffield/lazydocker) | Docker TUI client |
| [yazi](https://github.com/sxyazi/yazi) | Terminal file manager |

### Additional

| Tool | Purpose |
|---|---|
| [tmux](https://github.com/tmux/tmux) | Terminal multiplexer |
| [thefuck](https://github.com/nvbn/thefuck) | Command autocorrection |
| [tldr](https://github.com/tldr-pages/tldr) | Simplified man pages |
| [btop](https://github.com/aristocratos/btop) | System monitor |
| [direnv](https://github.com/direnv/direnv) | Per-directory environment variables |
| [dust](https://github.com/bootandy/dust) | Disk usage analyzer |
| [procs](https://github.com/dalance/procs) | Process viewer |
| [gh](https://cli.github.com/) | GitHub CLI |
| [just](https://github.com/casey/just) | Task runner |
| [age](https://github.com/FiloSottile/age) | File encryption (used with [sops](https://github.com/getsops/sops)) |
| [tfswitch](https://github.com/warrensbox/terraform-switcher) | Terraform version manager (Linux: pinned binary; macOS: Brewfile) |

### DevOps

| Tool | Purpose |
|---|---|
| [ansible](https://docs.ansible.com/) | Configuration management |
| [kubectl](https://kubernetes.io/docs/reference/kubectl/) | Kubernetes CLI |
| [helm](https://helm.sh/) | Kubernetes package manager |

### Linters & formatters

Installed by `lint-tools` (bundled into `*-install` on Linux, Brewfile on macOS). Used by Neovim (conform.nvim / nvim-lint) and CI.

| Tool | Purpose |
|---|---|
| [shellcheck](https://www.shellcheck.net/) | Shell script linter |
| [shfmt](https://github.com/mvdan/sh) | Shell formatter |
| [stylua](https://github.com/JohnnyMorganz/StyLua) | Lua formatter |
| [luacheck](https://github.com/lunarmodules/luacheck) | Lua linter |
| [taplo](https://taplo.tamasfe.dev/) | TOML linter/formatter |
| [gitleaks](https://github.com/gitleaks/gitleaks) | Secret scanner |
| [ruff](https://docs.astral.sh/ruff/) | Python linter/formatter |
| [ty](https://docs.astral.sh/ty/) | Python type checker |
| [prettier](https://prettier.io/) | JS/TS/CSS/HTML formatter |
| [hadolint](https://github.com/hadolint/hadolint) | Dockerfile linter |
| [tflint](https://github.com/terraform-linters/tflint) | Terraform linter |
| [ansible-lint](https://ansible.readthedocs.io/projects/lint/) | Ansible linter |

### Personal tools

| Repo | Purpose |
|---|---|
| [tools](https://github.com/Aapok0/tools) | Clone with `just tools-clone`, on `PATH` via [zsh config](zsh/) |

## macOS Setup

A [Brewfile](Brewfile) is included for one-command macOS setup:

```bash
brew bundle --file=Brewfile
```

This installs all CLI tools, fonts, the default terminal emulator (Ghostty), age, and linters/formatters.

## CI

Pull requests run two smoke-test jobs (see [`.github/workflows/smoke-test.yml`](.github/workflows/smoke-test.yml)):

| Job | When | What |
|-----|------|------|
| **static checks** | always | `just --summary`, Brewfile resolve check (Homebrew on Linux) |
| **lint-tools** (debian / fedora / arch) | `justfile`, `Brewfile`, `justlib.sh`, or test harness changes | `just lint-tools` in distro containers |

The lint-tools matrix is gated on relevant file changes but **always reports success** when skipped, so both jobs are safe to mark as required in branch protection.

Run locally:

```bash
tests/run brewfile              # host; needs Homebrew (macOS or Linuxbrew)
tests/run lint-tools            # all three distros (Docker)
tests/run lint-tools debian     # one distro
```

## Font

All configs use **JetBrainsMono Nerd Font**, installed automatically by `just install` (or `just font-install`):

- **macOS:** via Brewfile (`font-jetbrains-mono-nerd-font`)
- **Arch:** `ttf-jetbrains-mono-nerd` (pacman)
- **Fedora:** `jetbrains-mono-fonts-all` (dnf) + Nerd Font patch from [nerdfonts.com](https://www.nerdfonts.com/font-downloads)
- **Debian:** downloaded from [nerd-fonts releases](https://github.com/ryanoasis/nerd-fonts/releases)

## Machine-Specific Config

Use `~/.config/zsh/.zshrc.local` for settings specific to one machine (not tracked):

```zsh
export MY_API_KEY="secret"
alias work='cd ~/projects/work'
```

Use `~/.config/git/config.local` for git credentials (not tracked):

```ini
[user]
    name = Your Name
    email = your@email.com
```
