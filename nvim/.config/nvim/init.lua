if vim.api.nvim_eval 'exists("g:vscode")' == 1 then
  require "user.vscode"
else
  require "user.options"
  require "user.keymaps"
  require "user.plugins"
  require "user.colorscheme"
  require "user.cmp"
  require "user.lsp"
  require "user.nvim-tree"
  require "user.lualine"
  require "user.flutter-tools"
  require "user.telescope"
  require "user.treesitter"
  require "user.comment"
  require "user.gitsigns"
  require "user.lsp-fastaction"
  require "user.autosave"
  require "user.augroups"
  require "user.lsp-status"
  require "user.toggleterm"
  require "user.whichkey"
  require "user.test"
  require "user.dap"
  require "user.autopairs"
end
