-- Shorten function name
local keymap = vim.keymap.set

-- Remap space as leader key
keymap("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

-- Resize with arrows
keymap("n", "<A-Up>", ":resize +2<CR>")
keymap("n", "<A-Down>", ":resize -2<CR>")
keymap("n", "<A-Left>", ":vertical resize -2<CR>")
keymap("n", "<A-Right>", ":vertical resize +2<CR>")

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==")
keymap("v", "<A-k>", ":m .-2<CR>==")

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv")
keymap("x", "K", ":move '<-2<CR>gv-gv")
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv")
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv")

keymap("v", "p", '"_dP')

vim.keymap.set("n", "<D-p>", function()
  local opts = {
    hidden = true,
  }
  require("telescope.builtin").find_files(opts)
end)
vim.keymap.set("n", "<D-F>", function()
  require("telescope.builtin").live_grep(
    require("telescope.themes").get_dropdown()
  )
end)

-- For easy navigation of wrapped lines
vim.cmd [[
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'
]]

function _G.abbreviate_or_noop(input, output)
  local cmdtype = vim.fn.getcmdtype()
  local cmdline = vim.fn.getcmdline()

  if cmdtype == ":" and cmdline == input then
    return output
  else
    return input
  end
end

function SetupCommandAlias(input, output)
  vim.api.nvim_command(
    "cabbrev <expr> "
      .. input
      .. " "
      .. "v:lua.abbreviate_or_noop('"
      .. input
      .. "', '"
      .. output
      .. "')"
  )
end

SetupCommandAlias("W", "w")
SetupCommandAlias("Wa", "wa")
SetupCommandAlias("Q", "q")
SetupCommandAlias("Qa", "qa")

-- Remap CTRL+K to allow enter digraphs (CTRL-Y RT for √)
keymap("i", "<C-y>", "<C-k>")

--dial
vim.keymap.set("n", "<C-a>", function()
  return require("dial.map").inc_normal()
end, { noremap = true, silent = true, expr = true })
vim.keymap.set("n", "<C-x>", function()
  return require("dial.map").dec_normal()
end, { noremap = true, silent = true, expr = true })
vim.keymap.set("v", "<C-a>", function()
  return require("dial.map").inc_visual()
end, { noremap = true, silent = true, expr = true })
vim.keymap.set("v", "<C-x>", function()
  return require("dial.map").dec_visual()
end, { noremap = true, silent = true, expr = true })

keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "n", "nzz")

keymap("n", "<leader>w", "<cmd>update<CR>")
