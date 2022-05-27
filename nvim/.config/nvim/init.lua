if not vim.g.vscode then
  require "user.options"
  require "user.keymaps"
  require "user.plugins"
  require "user.colorscheme"
  require "user.lsp"
  require "user.autocommands"
  require "user.winbar"
else
  require "user.vscode"
end
