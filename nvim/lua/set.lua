-------------------------------------------------------
-- GENERAL
-------------------------------------------------------

-- Abbreviated variables to write less when configuring
local opt = vim.opt -- same as set in vimscript
local g = vim.g -- global variables

-- Mouse support enabled for all modes
opt.mouse = 'a'

-- Disable modelines, when not in use (reads x lines from head/tail of file)
opt.modelines = 0

-- Make sure to have utf8 standard encoding
opt.fileencoding = 'utf8'

-- Use Unix as the standard file type
opt.fileformats = 'unix,dos'

-- Automatically reads any changes made to the current open file by someone else
opt.autoread = true

-- Hide buffer messages = you can have unsaved changes, when opening more files
opt.hidden = true

-------------------------------------------------------
-- USABILITY
-------------------------------------------------------

-- Disable backup and swap
opt.backup = false
opt.swapfile = false

-- Undofile -> persistent undo
opt.undofile = true
opt.undodir = os.getenv('HOME') ..  '/.vim/undodir'

-- Show line number
opt.number = true

-- Show relative number
opt.relativenumber = true

-- Draws signcolumn next to numbers
opt.signcolumn = 'auto'

-- Highlight the line your cursor is on
opt.cursorline = true

-- Show column and line position
opt.ruler = true

-- When scrolling up or down, keep cursor 10 lines from top or bottom
opt.scrolloff = 10

-- When scrolling sideways (without wrap), keep cursor 10 lines from right or left
opt.sidescrolloff = 10

-- Split window right and below
opt.splitright = true
opt.splitbelow = true

-- Autocomplete commands by using tab - move between choices with tab and s-tab
opt.wildmenu = true
opt.wildmode = 'longest:list,full'

-- Case-insensitive search, when searching all lowercase
opt.ignorecase = true
opt.smartcase = true

-- Highlight search results
opt.hlsearch = true

-- Search incrementally as you write
opt.incsearch = true

-- Don't redraw while executing macros
opt.lazyredraw = true

-- No need to backslash special characters with regex
opt.magic = true

-- Sets regex engine automatically
opt.regexpengine = 0

-- When over a bracket, show the other matching one
opt.showmatch = true

-- No sound on errors
--opt.noerrorbells = true
--opt.novisualbell = true
--opt.t_vb = ''
--opt.tm = 500

-------------------------------------------------------
-- COLOR
-------------------------------------------------------

-- Use 24-bit color
opt.termguicolors = true

-- Set colorscheme and background (colorscheme currently set in catpuccin.lua file)
--vim.cmd("colorscheme catpuccin")
opt.background = 'dark'

-- Set whitespace characters to dark gray
vim.cmd('highlight Whitespace guifg=#5A5A5A')

-- Forced transparent background
--vim.cmd('highlight Normal guibg=None')
--vim.cmd('highlight NonText guibg=None')
--vim.cmd('highlight Normal ctermbg=None')
--vim.cmd('highlight NonText ctermbg=None')

-------------------------------------------------------
-- INDENTATION AND WRAPPING
-------------------------------------------------------

-- Use spaces when tabbing
opt.expandtab = true

-- Uses tabs according to situation
opt.smarttab = true

-- One tab shifts 4 spaces and indents rounded to shiftwidth
opt.shiftwidth = 4
opt.shiftround = true
opt.tabstop = 4
opt.softtabstop = 4

-- Smart auto indentation
opt.smartindent = true

-- Change indent to 2 spaces with following filetypes
vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'html',
    'javascript',
    'javascriptreact',
    'typescript',
    'css',
    'ansible',
    'terraform',
    'terraform-vars',
    'markdown',
    'lua',
  },
  command = 'setlocal shiftwidth=2 tabstop=2 softtabstop=2'
})

-- Characters for tabs and spaces
vim.opt.list = true
vim.opt.listchars = {
  --eol = '⤶',
  tab = '▷▷',
  lead = '⋅',
  trail = '✚',
  extends = '◀',
  precedes = '▶',
}

-- Linebreak after 300 characters nonstop
--opt.linebreak = true
--opt.textwidth = 300

-- Wrap lines
opt.wrap = true

-------------------------------------------------------
-- PLUGINS
-------------------------------------------------------

-- Disable netrw for nvim tree plugin
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- Disable virtual text for diagnostics plugins (using trouble plugin instead)
vim.diagnostic.config({
  virtual_text = false,
})
