-------------------------------------------------------
-- GENERAL
-------------------------------------------------------

-- Abbreviated variables to write less when configuring
local g = vim.g -- global variables
local key = vim.keymap.set -- remap keys
local default_opts = { noremap = true, silent = true }

-- Change map leader - more key combinations
g.mapleader = ' '

-- Alias for exiting a mode
key('i', 'jk', '<esc>', default_opts)
key('v', 'jk', '<esc>', default_opts)

-- Alias for yanking to and pasting from clipboard
key('v', '<leader>y', '"+y', default_opts)
key('n', '<leader>p', '"+p', default_opts)

-- Go back to visual mode when indenting in visual mode
key('v', '<', '<gv', default_opts)
key('v', '>', '>gv', default_opts)

-------------------------------------------------------
-- PLUGINS
-------------------------------------------------------

-- Nvim tree
key('n', '<leader>tt', ':NvimTreeToggle<CR>', default_opts) -- toggle tree
key('n', '<leader>tf', ':NvimTreeFocus<CR>', default_opts) -- toggle tree focus

-- Undotree
key('n', '<leader>u', ':UndotreeToggle<CR>', default_opts) -- toggle undotree

-- Trouble
key("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", default_opts)
key("n", "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", default_opts)
key("n", "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", default_opts)
key("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", default_opts)
key("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", default_opts)
key("n", "<leader>xL", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", default_opts)

-- Telescope
-- Mappings in telescope.lua

-- Copilot
key("n", "<leader>cp", "<cmd>Copilot panel<cr>", default_opts)

-- Copilot chat
-- Quick chat with Copilot
key("n", "<leader>cq",
  function()
    local input = vim.fn.input("Quick Chat: ")
      if input ~= "" then
        require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
      end
  end
)
-- Show Copilot help actions with telescope (DOES NOT WORK)
key("n", "<leader>ch",
  function()
    local actions = require("CopilotChat.actions")
    require("CopilotChat.integrations.telescope").pick(actions.help_actions())
  end
)
-- Show Copilot prompts actions with telescope
key("n", "<leader>pp",
  function()
    local actions = require("CopilotChat.actions")
    require("CopilotChat.integrations.telescope").pick(actions.prompt_actions({ selection = require("CopilotChat.select").buffer }))
  end
)
