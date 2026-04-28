return {
  -- Startup menu
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
      require('alpha').setup(require'alpha.themes.startify'.config)
    end
  },

  -- Undotree - go through old changes
  'mbbill/undotree',

  -- Telescope - fuzzy finder for moving between files
  -- Config in ../telescope.lua
  {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    }
  },

  -- LSP and completions
  -- Config in ../lsp.lua
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', build = function() pcall(vim.cmd, 'MasonUpdate') end },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-path' },
      { 'L3MON4D3/LuaSnip' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'onsails/lspkind.nvim' },
      { 'b0o/schemastore.nvim' },
    },
  },

  -- Trouble - show diagnostics in a list over statusline
  {
    'folke/trouble.nvim',
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
  },

  -- Vim tmux navigator
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },

  -- Vim-fugitive - git features in vim
  'tpope/vim-fugitive',

  -- Plugins in separate files

  -- Better statusline
  --lualine.lua

  -- Nvim filetree and devicons for filetypes
  --nvimtree.lua

  -- Treesitter - more advanced syntax highlighting
  --treesitter.lua

  -- Indent lines
  --indent-blankline.lua

  -- Gitsigns - show signs of git changes
  --gitsigns.lua

  -- Better colorschemes
  --catppuccin.lua

  -- Copilot completions and chat
  --copilot.lua

  -- Formatting
  --conform.lua

  -- Linting
  --nvim-lint.lua

  -- Keybinding hints
  --which-key.lua

  -- File explorer (buffer-based)
  --oil.lua

  -- LSP progress indicator
  --fidget.lua

  -- TODO comment highlighting
  --todo-comments.lua
}
