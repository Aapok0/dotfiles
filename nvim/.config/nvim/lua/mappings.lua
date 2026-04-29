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
key('i', 'jk', '<esc>', { noremap = true, silent = true, desc = "Exit insert mode" })
key('v', 'jk', '<esc>', { noremap = true, silent = true, desc = "Exit visual mode" })

-- Alias for yanking to and pasting from clipboard
key('v', '<leader>y', '"+y', { noremap = true, silent = true, desc = "Yank to clipboard" })
key('n', '<leader>p', '"+p', { noremap = true, silent = true, desc = "Paste from clipboard" })

-- Go back to visual mode when indenting in visual mode
key('v', '<', '<gv', { noremap = true, silent = true, desc = "Indent left and reselect" })
key('v', '>', '>gv', { noremap = true, silent = true, desc = "Indent right and reselect" })

-------------------------------------------------------
-- PLUGINS
-------------------------------------------------------

-- Nvim tree
key('n', '<leader>tt', ':NvimTreeToggle<CR>', { noremap = true, silent = true, desc = "NvimTree: Toggle" })
key('n', '<leader>tf', ':NvimTreeFocus<CR>', { noremap = true, silent = true, desc = "NvimTree: Focus" })

-- Undotree
key('n', '<leader>u', ':UndotreeToggle<CR>', { noremap = true, silent = true, desc = "Undotree: Toggle" })

-- Trouble
key("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { noremap = true, silent = true, desc = "Trouble: Toggle diagnostics" })
key("n", "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { noremap = true, silent = true, desc = "Trouble: Buffer diagnostics" })
key("n", "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", { noremap = true, silent = true, desc = "Trouble: Symbols" })
key("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", { noremap = true, silent = true, desc = "Trouble: Location list" })
key("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { noremap = true, silent = true, desc = "Trouble: Quickfix list" })
key("n", "<leader>xL", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { noremap = true, silent = true, desc = "Trouble: LSP references" })

-- Telescope
-- Mappings in telescope.lua

-- Copilot
key("n", "<leader>cp", "<cmd>Copilot panel<cr>", { noremap = true, silent = true, desc = "Copilot: Open panel" })

-- Copilot chat
-- Quick chat with Copilot
key("n", "<leader>cq",
  function()
    local input = vim.fn.input("Quick Chat: ")
      if input ~= "" then
        require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
      end
  end,
  { desc = "CopilotChat: Quick chat" }
)
-- Show Copilot help actions with telescope
key("n", "<leader>ch",
  function()
    local actions = require("CopilotChat.actions")
    require("CopilotChat.integrations.telescope").pick(actions.help_actions())
  end,
  { desc = "CopilotChat: Help actions" }
)
-- Show Copilot prompts actions with telescope
key("n", "<leader>pp",
  function()
    local actions = require("CopilotChat.actions")
    require("CopilotChat.integrations.telescope").pick(actions.prompt_actions({ selection = require("CopilotChat.select").buffer }))
  end,
  { desc = "CopilotChat: Prompt actions" }
)
