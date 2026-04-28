-- LSP and completion configuration (replaces lsp-zero)

-- Diagnostic configuration
vim.diagnostic.config({
  virtual_text = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '✘',
      [vim.diagnostic.severity.WARN] = '▲',
      [vim.diagnostic.severity.HINT] = '⚑',
      [vim.diagnostic.severity.INFO] = '»',
    },
  },
})

-- Mason setup for automatic LSP server installation
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'ansiblels',
    'bashls',
    'dockerls',
    'docker_compose_language_service',
    'eslint',
    'helm_ls',
    'jsonls',
    'lua_ls',
    'pyright',
    'terraformls',
    'yamlls',
  },
  handlers = {
    -- Default handler for all servers
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,

    -- Lua LSP with Neovim runtime support
    lua_ls = function()
      require('lspconfig').lua_ls.setup({
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            workspace = {
              checkThirdParty = false,
              library = { vim.env.VIMRUNTIME },
            },
          },
        },
      })
    end,

    -- YAML LSP with schema support (Kubernetes, GitHub Actions, etc.)
    yamlls = function()
      require('lspconfig').yamlls.setup({
        settings = {
          yaml = {
            schemaStore = {
              enable = true,
              url = "https://www.schemastore.org/api/json/catalog.json",
            },
          },
        },
      })
    end,

    -- JSON LSP with schema support
    jsonls = function()
      require('lspconfig').jsonls.setup({
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
      })
    end,
  }
})

-- Completion setup
local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "luasnip" },
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol_text",
      max_width = 50,
      symbol_map = {
        Text = "󰉿",
        Method = "󰆧",
        Function = "󰊕",
        Constructor = "",
        Field = "󰜢",
        Variable = "󰀫",
        Class = "󰠱",
        Interface = "",
        Module = "",
        Property = "󰜢",
        Unit = "󰑭",
        Value = "󰎠",
        Enum = "",
        Keyword = "󰌋",
        Snippet = "",
        Color = "󰏘",
        File = "󰈙",
        Reference = "󰈇",
        Folder = "󰉋",
        EnumMember = "",
        Constant = "󰏿",
        Struct = "󰙅",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "",
      }
    })
  },
  mapping = cmp.mapping.preset.insert({
    -- scroll up and down the documentation window
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})
