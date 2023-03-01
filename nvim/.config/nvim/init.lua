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
if not vim.g.vscode then
  require "user.options"
  require "user.keymaps"
  require("lazy").setup("plugins", {

    dev = {
      -- directory where you store your local plugin projects
      path = "~/Documents/github/personal",
    },
  })
  require "user.colorscheme"
  require "user.lsp"
  require "user.autocommands"
  require "user.winbar"
else
  require "user.vscode"
end
