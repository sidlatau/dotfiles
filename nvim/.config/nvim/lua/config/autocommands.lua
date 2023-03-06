local function augroup(name)
  return vim.api.nvim_create_augroup("ts_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup "fix_all_on_save",
  pattern = "*.dart",
  callback = function()
    require("config.lsp.handlers").code_action_fix_all()
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup "close_with_q",
  pattern = {
    "qf",
    "help",
    "man",
    "notify",
    "lspinfo",
    "dap-float",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set(
      "n",
      "q",
      "<cmd>close<cr>",
      { buffer = event.buf, silent = true }
    )
  end,
})

local general_settings = augroup "general_settings"
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = general_settings,
  pattern = "gitcommit,markdown",
  command = [[setlocal spell]],
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  group = general_settings,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank {
      higroup = "Search",
      timeout = 150,
    }
  end,
})

vim.api.nvim_create_autocmd(
  { "CursorMoved", "BufWinEnter", "BufFilePost", "InsertEnter", "BufWritePost" },
  {
    group = augroup "winbar",
    callback = function()
      require("config.winbar").get_winbar()
    end,
  }
)

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup "resize_splits",
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})
