local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

require("vim-options")
require("keymaps")
require("lazy").setup({
  spec = {
    { import = "plugins" }, -- loads all plugins in plugins/
  },
  defaults = {
    lazy = false, -- plugins are not lazy loaded by default
    },
})

vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand('~/.local/share/nvim/undo')
vim.cmd.colorscheme "gruvbox"
