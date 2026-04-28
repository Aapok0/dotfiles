return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    local parsers = {
      'bash',
      'diff',
      'markdown',
      'markdown_inline',
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
    }

    -- New API (nvim-treesitter 1.x, Neovim 0.12+)
    -- Old API (nvim-treesitter 0.x, Neovim 0.11)
    local ok, configs = pcall(require, 'nvim-treesitter.configs')
    if ok then
      configs.setup {
        ensure_installed = parsers,
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      }
    else
      require('nvim-treesitter').setup {
        ensure_installed = parsers,
        auto_install = true,
      }
    end
  end
}
