return {
  'nvim-treesitter/nvim-treesitter',
  config = function()
    -- https://github.com/nvim-treesitter/nvim-treesitter#modules
    require'nvim-treesitter.configs'.setup {
      -- A list of parser names, or "all" (c, lua, vim, vimdoc adn query should always be installed)
      ensure_installed = {
        'bash',
        'markdown',
        'python',
        'html',
        'css',
        'scss',
        'php',
        'javascript',
        'typescript',
        'json',
        'yaml',
        'hcl',
        'terraform',
        'dockerfile',
        'c',
        'lua',
        'vim',
        'vimdoc',
        'query',
      },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,

      highlight = {
        enable = false,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false, -- required for catpuccin
      },
    }
  end
}
