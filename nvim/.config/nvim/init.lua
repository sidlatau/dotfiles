if not vim.g.vscode then
  require "user.options"
  require "user.keymaps"
  require "user.plugins"
  require "user.colorscheme"
  require "user.lsp"
  require "user.augroups"
  require "user.winbar"
else
  require "user.vscode"
end
