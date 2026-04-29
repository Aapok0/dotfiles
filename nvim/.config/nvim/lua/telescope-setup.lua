-- Telescope https://github.com/nvim-telescope/telescope.nvim#usage
local telescope = require('telescope')
local builtin = require('telescope.builtin')

-- Load fzf-native for better sorting performance
telescope.load_extension('fzf')

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Telescope: Find files" })
vim.keymap.set('n', '<leader>fr', builtin.live_grep, { desc = "Telescope: Live grep" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Telescope: Buffers" })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Telescope: Help tags" })
vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = "Telescope: Git files" })
