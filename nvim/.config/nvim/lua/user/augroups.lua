local fix_all_on_save = vim.api.nvim_create_augroup("fix_all_on_save", {})
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = fix_all_on_save,
  pattern = "*.dart",
  callback = function()
    require("user.lsp.handlers").code_action_fix_all()
  end,
})

local general_settings = vim.api.nvim_create_augroup("general_settings", {})
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = general_settings,
  pattern = "qf,help,man,lspinfo",
  command = [[nnoremap <silent> <buffer> q :close<CR>]],
})
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = general_settings,
  pattern = "gitcommit,markdown",
  command = [[setlocal spell]],
})

vim.api.nvim_create_autocmd(
  { "CursorMoved", "BufWinEnter", "BufFilePost", "InsertEnter", "BufWritePost" },
  {
    callback = function()
      require("user.winbar").get_winbar()
    end,
  }
)
