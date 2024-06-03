local grpid =
  vim.api.nvim_create_augroup("custom_highlights_gruvboxmaterial", {})
vim.api.nvim_create_autocmd("ColorScheme", {
  group = grpid,
  pattern = "gruvbox-material",
  callback = function()
    vim.cmd [[highlight  WinBar NONE]]
    vim.cmd [[hi NormalFloat guibg=#1d2021 | hi FloatBorder guibg=#1d2021]]
  end,
  -- floating popups for neo-tree
})

return {
  "sainnhe/gruvbox-material",
  commit = "8f504421acd991b786ae6796176a1c5878221052",
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.gruvbox_material_background = "hard"
    vim.g.gruvbox_material_better_performance = 1
    vim.g.gruvbox_material_enable_bold = 0
    vim.g.gruvbox_material_visual = "green background"
    vim.g.gruvbox_material_show_eob = 0
    vim.g.gruvbox_material_diagnostic_text_highlight = 1
    vim.g.gruvbox_material_diagnostic_virtual_text = 1
    vim.g.gruvbox_material_enable_italic = 1
    vim.g.gruvbox_material_transparent_background = 2
    vim.print "Setting colorscheme to gruvbox-material"
    vim.cmd.colorscheme "gruvbox-material"
  end,
}
