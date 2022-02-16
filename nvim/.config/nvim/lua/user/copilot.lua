vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""
vim.g.copilot_filetypes = {
  ["*"] = false,
  gitcommit = false,
  NeogitCommitMessage = false,
  dart = true,
  lua = true,
}
vim.api.nvim_set_keymap(
  "i",
  "<c-h>",
  [[copilot#Accept("\<CR>")]],
  { expr = true, script = true }
)
