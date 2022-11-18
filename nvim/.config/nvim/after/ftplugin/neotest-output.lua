vim.keymap.set("n", "q", function()
  pcall(vim.api.nvim_buf_delete, 0, { force = true })
end, { buffer = 0 })
