local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
  return
end

toggleterm.setup {
  size = 20,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = "float",
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
}

function _G.set_terminal_keymaps()
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

vim.api.nvim_create_user_command("RegenerateSingleDirectory", function()
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
end, {})
