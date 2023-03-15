local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
  return
end

M = {}

local function set_terminal_keymaps()
  local opts = { noremap = true }
  vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

vim.api.nvim_create_autocmd({ "TermOpen" }, {
  pattern = "term://*",
  callback = set_terminal_keymaps,
})

M.regenerate_single_directory = function()
  local git_dir = require("toggleterm.utils").git_dir() .. "/"
  local root_path = vim.fn.expand "%:h"
  local extension = vim.fn.expand "%:e"
  local relative_path = root_path:gsub(git_dir, "")
  local command = string.format(
    'fvm flutter pub run build_runner build --build-filter="%s/*.%s"',
    relative_path,
    extension
  )
  toggleterm.exec(command, 1)
end

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new {
  cmd = "lazygit",
  on_open = function(term)
    vim.cmd "startinsert!"
    vim.api.nvim_buf_set_keymap(
      0,
      "t",
      "<esc>",
      "<cmd>close<CR>",
      { silent = false, noremap = true }
    )
    if vim.fn.mapcheck("<esc>", "t") ~= "" then
      vim.api.nvim_buf_del_keymap(term.bufnr, "t", "<esc>")
    end
  end,
}

function M.lazygit_toggle()
  lazygit:toggle()
end

return M
