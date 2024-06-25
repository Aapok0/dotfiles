return {
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    -- https://github.com/nvim-tree/nvim-tree.lua#quick-start
    require('nvim-tree').setup({
      sort_by = "name",
      view = {
        width = 30,
      },
      filters = {
        dotfiles = true,
      },
    })
  end
}
