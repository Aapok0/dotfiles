# Neovim configurations with lua

Modern Neovim configuration using Lua with [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager. Plugins are automatically installed on first launch.

## Setup

1. Back up any existing config: `mv ~/.config/nvim ~/.config/nvim.bak`
2. Symlink or copy the config: `ln -s /path/to/dotfiles/nvim/.config/nvim ~/.config/nvim`
3. Install the [required dependencies](#required-dependencies)
4. Open Neovim — Lazy will automatically install all plugins on first launch
5. Run `:Lazy sync` to ensure everything is up to date
6. Mason will auto-install LSP servers listed in `lsp.lua` — you can also run `:Mason` to manage them manually

### Installing formatters and linters

Formatters and linters used by conform.nvim and nvim-lint are **not** auto-installed. Install them via your package manager or `:MasonInstall`:

```bash
# Via Mason (inside Neovim)
:MasonInstall shfmt stylua prettier ruff hadolint tflint ansible-lint

# Or via system package manager (example for macOS)
brew install shfmt stylua prettier ruff hadolint tflint ansible-lint
```

## Plugins

### Core

| Plugin | Description |
|---|---|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager. Run `:Lazy` to open the UI |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP client configurations |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | Portable LSP/formatter/linter installer. Run `:Mason` to manage |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Autocompletion engine with LSP, path, and snippet sources |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Advanced syntax highlighting and code parsing |

### Navigation & files

| Plugin | Description |
|---|---|
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder for files, grep, buffers, and more |
| [telescope-fzf-native](https://github.com/nvim-telescope/telescope-fzf-native.nvim) | C-compiled fzf sorter for Telescope performance |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | File tree sidebar |
| [oil.nvim](https://github.com/stevearc/oil.nvim) | Edit filesystem like a buffer. Press `-` to open parent directory |
| [alpha-nvim](https://github.com/goolord/alpha-nvim) | Start screen dashboard |

### Git

| Plugin | Description |
|---|---|
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | Git commands inside Neovim (`:Git`, `:Gblame`, etc.) |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git change indicators in the sign column |

### Code quality

| Plugin | Description |
|---|---|
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Format on save. Supports shfmt, stylua, ruff, prettier, terraform fmt. Run `:ConformInfo` to check status |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint) | Async linting on save/insert leave. Supports hadolint, tflint, ansible-lint |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | Diagnostics list panel |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | Highlights `TODO`, `FIXME`, `HACK` comments in code |

### AI

| Plugin | Description |
|---|---|
| [copilot.lua](https://github.com/zbirenbaum/copilot.lua) | GitHub Copilot inline suggestions (ghost text). Requires `:Copilot auth` on first use |
| [CopilotChat.nvim](https://github.com/CopilotC-Nvim/CopilotChat.nvim) | Chat with Copilot about your code |

### UI & UX

| Plugin | Description |
|---|---|
| [catppuccin](https://github.com/catppuccin/nvim) | Color scheme (mocha variant, transparent background) |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Status line with branch, diagnostics, file info |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Indentation guides |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Keybinding hints — press `<Space>` and wait to see available mappings |
| [fidget.nvim](https://github.com/j-hui/fidget.nvim) | LSP progress indicator (bottom-right corner) |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | File type icons |
| [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) | In-buffer markdown rendering (headings, tables, checkboxes) |
| [undotree](https://github.com/mbbill/undotree) | Visual undo history browser |
| [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) | Seamless navigation between Neovim and tmux panes |

## LSP servers

The following language servers are auto-installed via Mason:

| Server | Language/Tool |
|---|---|
| `ansiblels` | Ansible |
| `bashls` | Bash/Shell |
| `dockerls` | Dockerfile |
| `docker_compose_language_service` | Docker Compose |
| `eslint` | JavaScript/TypeScript linting |
| `helm_ls` | Helm charts |
| `jsonls` | JSON (with SchemaStore) |
| `lua_ls` | Lua (configured for Neovim runtime) |
| `pyright` | Python |
| `terraformls` | Terraform/HCL |
| `yamlls` | YAML (with SchemaStore for K8s, GitHub Actions, etc.) |

## Keybindings

Leader key is `<Space>`. Press it and wait for which-key to show available options.

All mappings below use `<Space>` as `<leader>`. Neovim 0.11+ also provides default LSP mappings (`K` for hover, `grn` for rename, `grr` for references, `gra` for code actions, `gri` for implementations, `gO` for document symbols).

### General

| Key | Mode | Action |
|---|---|---|
| `jk` | Insert/Visual | Exit to normal mode |
| `<leader>y` | Visual | Yank to system clipboard |
| `<leader>p` | Normal | Paste from system clipboard |
| `<` / `>` | Visual | Indent and stay in visual mode |

### Telescope (find)

| Key | Action |
|---|---|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (search text in project) |
| `<leader>fb` | List open buffers |
| `<leader>fh` | Search help tags |
| `<leader>gf` | Find git files |

### File tree & explorer

| Key | Action |
|---|---|
| `<leader>tt` | Toggle nvim-tree sidebar |
| `<leader>tf` | Focus nvim-tree |
| `-` | Open parent directory in Oil |

### Diagnostics (Trouble)

| Key | Action |
|---|---|
| `<leader>xx` | Toggle workspace diagnostics |
| `<leader>xb` | Toggle buffer diagnostics |
| `<leader>xs` | Toggle document symbols |
| `<leader>xl` | Toggle location list |
| `<leader>xq` | Toggle quickfix list |
| `<leader>xL` | Toggle LSP definitions/references panel |

### Copilot

| Key | Mode | Action |
|---|---|---|
| `<M-l>` | Insert | Accept Copilot suggestion |
| `<M-]>` / `<M-[>` | Insert | Next/previous suggestion |
| `<C-]>` | Insert | Dismiss suggestion |
| `<leader>cp` | Normal | Open Copilot panel |
| `<leader>cq` | Normal | Quick chat with Copilot |
| `<leader>ch` | Normal | Copilot help actions (via Telescope) |
| `<leader>pp` | Normal | Copilot prompt actions (via Telescope) |

### Formatting

| Key | Action |
|---|---|
| `<leader>cf` | Format buffer manually |
| _(automatic)_ | Format on save is enabled |

### Other

| Key | Action |
|---|---|
| `<leader>u` | Toggle undo tree |
| `<C-h/j/k/l>` | Navigate between Neovim/tmux panes |

### Completion (nvim-cmp)

| Key | Action |
|---|---|
| `<C-u>` / `<C-d>` | Scroll documentation window |
| `<C-n>` / `<C-p>` | Next/previous completion item |
| `<CR>` | Confirm selection |

## File structure

```
~/.config/nvim/
├── init.lua                    # Entry point — loads set, mappings, lazynvim
├── lazy-lock.json              # Plugin version lock file
└── lua/
    ├── set.lua                 # Vim options (general, indentation, colors)
    ├── mappings.lua            # Custom keybindings
    ├── lazynvim.lua            # Lazy.nvim bootstrap and plugin loading
    ├── lsp.lua                 # LSP, Mason, and completion configuration
    ├── telescope.lua           # Telescope setup and keybindings
    └── plugins/                # Plugin specs (one per file)
        ├── init.lua            # Core plugins (telescope, lsp deps, trouble, etc.)
        ├── catppuccin.lua      # Color scheme
        ├── conform.lua         # Formatting
        ├── copilot.lua         # Copilot + CopilotChat
        ├── fidget.lua          # LSP progress
        ├── gitsigns.lua        # Git signs
        ├── indent-blankline.lua
        ├── lualine.lua         # Status line
        ├── nvim-lint.lua       # Linting
        ├── nvimtree.lua        # File tree
        ├── oil.lua             # Oil file explorer
        ├── render-markdown.lua # Markdown rendering
        ├── todo-comments.lua   # TODO highlighting
        ├── treesitter.lua      # Syntax highlighting
        └── which-key.lua       # Keybinding hints
```

## Required dependencies

### Clipboard (Linux only)

Neovim auto-detects the clipboard provider. On macOS, `pbcopy`/`pbpaste` are used natively.

```bash
# X11 (Debian/Ubuntu)
sudo apt-get install xclip

# X11 (Fedora)
sudo dnf install xclip

# X11 (Arch)
sudo pacman -S xclip

# Wayland (Debian/Ubuntu)
sudo apt-get install wl-clipboard

# Wayland (Fedora)
sudo dnf install wl-clipboard

# Wayland (Arch)
sudo pacman -S wl-clipboard
```

### Ripgrep (required for Telescope live grep)

```bash
# Debian/Ubuntu
sudo apt-get install ripgrep

# Fedora
sudo dnf install ripgrep

# Arch
sudo pacman -S ripgrep

# macOS
brew install ripgrep
```

### Node.js (required for some LSP servers)

```bash
# Debian/Ubuntu
sudo apt-get install nodejs npm

# Fedora
sudo dnf install nodejs npm

# Arch
sudo pacman -S nodejs npm

# macOS
brew install node
```

### Python (required for some LSP servers)

```bash
# Debian/Ubuntu
sudo apt-get install python3

# Fedora
sudo dnf install python3

# Arch
sudo pacman -S python

# macOS
brew install python3
```

### C compiler (required for Treesitter parsers and telescope-fzf-native)

Most systems have this installed by default (`gcc` or `clang`).

```bash
# Debian/Ubuntu
sudo apt-get install build-essential

# Fedora
sudo dnf install gcc make

# Arch
sudo pacman -S base-devel

# macOS
xcode-select --install
```

## Minimum version

Neovim **0.10+** is required. Version **0.11+** is recommended for native LSP keybinding support.

```bash
# Check version
nvim --version

# Debian/Ubuntu (latest stable via PPA)
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update && sudo apt-get install neovim

# Fedora
sudo dnf install neovim

# Arch
sudo pacman -S neovim

# macOS
brew install neovim
```
