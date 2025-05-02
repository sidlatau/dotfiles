local grpid =
  vim.api.nvim_create_augroup("custom_highlights_gruvboxmaterial", {})
vim.api.nvim_create_autocmd("ColorScheme", {
  group = grpid,
  pattern = "gruvbox-material",
  callback = function()
    vim.cmd [[highlight  WinBar NONE]]
    -- Check system dark/light mode on macOS
    local handle = io.popen "defaults read -g AppleInterfaceStyle 2>/dev/null"
    local result = handle and handle:read "*a" or ""
    if handle then
      handle:close()
    end

    local is_dark_mode = result:match "Dark" ~= nil
    vim.g.gruvbox_material_background = is_dark_mode and "hard" or "light"

    if is_dark_mode then
      vim.cmd [[hi BlinkCmpMenu guibg=#1d2021 | hi BlinkCmpMenuBorder guibg=#1d2021]]
    else
      vim.cmd [[hi BlinkCmpMenu guibg=NONE | hi BlinkCmpMenuBorder guibg=NONE]]
    end
    vim.cmd [[hi DiagnosticWarn guibg=NONE]]
    vim.cmd [[hi DiagnosticInfo guibg=NONE]]
    vim.cmd [[hi DiagnosticError guibg=NONE]]
    vim.cmd [[ highlight NormalNC guibg=NONE]]
    vim.cmd [[hi NormalFloat guibg=NONE | hi FloatBorder guibg=NONE]]
    vim.cmd [[hi Normal guibg=NONE ctermbg=NONE]]
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
  end,
}
