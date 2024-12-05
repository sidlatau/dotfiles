local function augroup(name)
  return vim.api.nvim_create_augroup("ts_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup "fix_all_on_save",
  pattern = "*.dart",
  callback = function()
    local ok, err = pcall(require("config.lsp.handlers").code_action_fix_all)
    if not ok then
      vim.notify("Fix All error: " .. err, vim.log.levels.ERROR)
    else
      local format_ok, format_err = pcall(vim.lsp.buf.format)
      if not format_ok then
        vim.notify("Format error: " .. format_err, vim.log.levels.ERROR)
      end
    end
  end,
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  pattern = "*.cs",
  callback = function()
    local clients = vim.lsp.get_clients { name = "roslyn" }
    if not clients or #clients == 0 then
      return
    end

    local buffers = vim.lsp.get_buffers_by_client_id(clients[1].id)
    for _, buf in ipairs(buffers) do
      vim.lsp.util._refresh("textDocument/diagnostic", { bufnr = buf })
    end
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
    "log",
    "neotest-output",
    "vim",
    "dbout",
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

local Job = require "plenary.job"

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  group = augroup "generate_l10n_on_save",
  pattern = "*.arb",
  callback = function()
    Job:new({
      command = "fvm",
      args = { "flutter", "gen-l10n" },
      on_exit = function(j, return_val)
        if return_val ~= 0 then
          vim.schedule(function()
            vim.notify(
              table.concat(j:stderr_result(), "\n"),
              vim.log.levels.ERROR
            )
          end)
        else
          vim.schedule(function()
            vim.notify(table.concat(j:result(), "\n", vim.log.levels.INFO))
          end)
        end
      end,
    }):start()
  end,
})

-- Set up LspAttach autocommand to define keymaps when LSP client attaches to a buffer
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions", -- Optional description
  callback = function(args)
    local client = args.data and vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end
    local bufnr = args.buf -- Get the buffer number for the attached client
    require("config.lsp.handlers").on_attach(client, bufnr)
  end,
})

vim.api.nvim_create_autocmd("LspNotify", {
  callback = function(args)
    if args.data.method == "textDocument/didOpen" then
      vim.lsp.foldclose("imports", vim.fn.bufwinid(args.buf))
    end
  end,
})
