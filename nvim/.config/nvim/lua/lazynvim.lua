-- Bootstrap snippet from Packer Github repository https://github.com/folke/lazy.nvim?tab=readme-ov-file#-installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins and their configs
require("lazy").setup('plugins')
require("telescope")
require("lspzero")

-- Catppuccin setup must be called before loading
vim.cmd.colorscheme "catppuccin"
