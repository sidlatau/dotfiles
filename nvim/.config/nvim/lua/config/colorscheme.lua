vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_enable_bold = 0
vim.g.gruvbox_material_visual = "green background"
vim.g.gruvbox_material_show_eob = 0
vim.g.gruvbox_material_diagnostic_text_highlight = 1
vim.g.gruvbox_material_diagnostic_virtual_text = 1
vim.g.gruvbox_material_enable_italic = 1

local colorscheme = "gruvbox-material"
local grpid =
  vim.api.nvim_create_augroup("custom_highlights_gruvboxmaterial", {})
vim.api.nvim_create_autocmd("ColorScheme", {
  group = grpid,
  pattern = "gruvbox-material",
  -- floating popups
  command = "hi NormalFloat guibg=#282828 |" .. "hi FloatBorder guibg=#282828",
})

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end