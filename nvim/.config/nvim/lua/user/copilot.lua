vim.g.copilot_filetypes = {
  ["*"] = false,
  gitcommit = false,
  NeogitCommitMessage = false,
  dart = false,
  lua = true,
}
vim.api.nvim_set_keymap(
  "i",
  "<c-h>",
  [[copilot#Accept("")]],
  { expr = true, script = true }
)
