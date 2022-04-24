if vim.g.vscode == 1 then
  require "user.vscode"
else
  require "user.options"
  require "user.keymaps"
  require "user.plugins"
  require "user.colorscheme"
  require "user.lsp"
  require "user.augroups"
end
