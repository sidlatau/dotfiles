local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require "config.options"
require "config.keymaps"
require("lazy").setup("plugins", {
  dev = {
    -- directory where you store your local plugin projects
    path = "~/Documents/github/personal",
  },
})
require "config.colorscheme"
require "config.lsp"
require "config.autocommands"
require "config.winbar"
