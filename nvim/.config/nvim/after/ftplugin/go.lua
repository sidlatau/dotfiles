vim.keymap.set("n", "<leader>rr", "<cmd>GoRun<cr>", { buffer = 0 })

vim.keymap.set("n", "<leader>q", function()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
    end
  end
  print(qf_exists)
  if qf_exists == true then
    vim.cmd "cclose"
    return
  end
  vim.cmd "copen"
end, { buffer = 0 })
