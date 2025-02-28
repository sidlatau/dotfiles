local grpid =
  vim.api.nvim_create_augroup("custom_highlights_gruvboxmaterial", {})
vim.api.nvim_create_autocmd("ColorScheme", {
  group = grpid,
  pattern = "gruvbox-material",
  callback = function()
    vim.cmd [[highlight  WinBar NONE]]
    vim.cmd [[hi NormalFloat guibg=#1d2021 | hi FloatBorder guibg=#1d2021]]
    vim.cmd [[hi BlinkCmpMenu guibg=#1d2021 | hi BlinkCmpMenuBorder guibg=#1d2021]]
    vim.cmd [[hi DiagnosticWarn guibg=NONE]]
    vim.cmd [[hi DiagnosticInfo guibg=NONE]]
    vim.cmd [[hi DiagnosticError guibg=NONE]]
    vim.cmd [[ highlight NormalNC guibg=NONE]]
  end,
  -- floating popups for neo-tree
})

return {
  "sainnhe/gruvbox-material",
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.gruvbox_material_background = "hard"
    vim.g.gruvbox_material_better_performance = 1
    vim.g.gruvbox_material_enable_bold = 1
    vim.g.gruvbox_material_visual = "green background"
    vim.g.gruvbox_material_show_eob = 0
    vim.g.gruvbox_material_diagnostic_text_highlight = 1
    vim.g.gruvbox_material_diagnostic_virtual_text = 1
    vim.g.gruvbox_material_enable_italic = 1
    vim.cmd.colorscheme "gruvbox-material"
    vim.cmd [[hi Normal guibg=NONE ctermbg=NONE]]
  end,
}
