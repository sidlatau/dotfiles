local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

vim.cmd [[

  nnoremap <leader>t <Cmd>call VSCodeNotify('dart.goToTestOrImplementationFile')<CR>
  nnoremap <leader>r <Cmd>call VSCodeNotify('dart.debugTestAtCursor')<CR>
  nnoremap <leader>fr <Cmd>call VSCodeNotify('flutter.hotRestart')<CR>
  nnoremap gr <Cmd>call VSCodeNotify('references-view.findReferences')<CR>
]]

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end
return packer.startup(function(use)
  use "tpope/vim-surround"
  use "tpope/vim-repeat"
  use "tpope/vim-unimpaired"
  use "machakann/vim-highlightedyank"
end)
