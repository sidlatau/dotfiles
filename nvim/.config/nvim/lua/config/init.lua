local M = {}

M.toggle_flutter_log = function()
  local wins = vim.api.nvim_list_wins()
  for _, id in pairs(wins) do
    local bufnr = vim.api.nvim_win_get_buf(id)
    if
      vim.api.nvim_buf_get_name(bufnr):match ".*/([^/]+)$"
      == "__FLUTTER_DEV_LOG__"
    then
      return vim.api.nvim_win_close(id, true)
    end
  end

  pcall(function()
    vim.api.nvim_command "sb + __FLUTTER_DEV_LOG__ | resize 15 | wincmd p"

    wins = vim.api.nvim_list_wins()
    for _, id in pairs(wins) do
      local bufnr = vim.api.nvim_win_get_buf(id)
      local buf_name = vim.api.nvim_buf_get_name(bufnr)
      if buf_name:match ".*/([^/]+)$" == "__FLUTTER_DEV_LOG__" then
        -- Auto scroll to bottom
        local buf_length = vim.api.nvim_buf_line_count(bufnr)
        pcall(vim.api.nvim_win_set_cursor, id, { buf_length, 0 })
      end
    end
  end)
end

return M
