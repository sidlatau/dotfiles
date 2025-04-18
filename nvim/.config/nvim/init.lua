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

if vim.g.vscode then
  return
end
require("lazy").setup("plugins", {
  dev = {
    -- directory where you store your local plugin projects
    path = "~/Documents/github/personal",
  },
  {
    rocks = {
      hererocks = true, -- recommended if you do not have global installation of Lua 5.1.
    },
  },
})
require "config.lsp"
require "config.autocommands"
require "config.winbar"

if vim.fn.getenv "TERM_PROGRAM" == "ghostty" then
  vim.opt.title = true
  vim.opt.titlestring = "%{fnamemodify(getcwd(), ':t')}"
end
