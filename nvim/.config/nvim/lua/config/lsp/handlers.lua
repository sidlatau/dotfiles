local utils = require "clear-action.utils"

local M = {}

M.setup = function()
  local config = {
    virtual_text = false,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.INFO] = "",
        [vim.diagnostic.severity.HINT] = "",
        [vim.diagnostic.severity.WARN] = "",
      },
    },
    update_in_insert = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)
end

-- Add borders globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = "rounded"
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local function lsp_keymaps(bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_set_option_value(
    "omnifunc",
    "v:lua.vim.lsp.omnifunc",
    { buf = 0 }
  )

  local opts = { buffer = bufnr, silent = true }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "gr", function()
    require("telescope.builtin").lsp_references(
      require("telescope.themes").get_dropdown {
        layout_config = { width = 0.8 },
      }
    )
  end, opts)
  vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
end

M.on_attach = function(client, bufnr)
  if client.name == "ts_ls" or client.name == "lua_ls" then
    -- do not format by this LSP - conform will handle this is used for formatting
    client.server_capabilities.documentFormattingProvider = false
  end
  if client.name == "eslint" then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end
  lsp_keymaps(bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- local cmp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
-- if not cmp_status_ok then
--   return
-- end
--
-- M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
M.capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

local function lsp_execute_command(val)
  local client = vim.lsp.get_clients({ name = "dartls" })[1]
  if not client then
    print "No dartls client found"
    return
  end
  client.request("workspace/executeCommand", val.command, function(err)
    if err then
      print("Error executing command: " .. err.message)
    end
  end, 0)
end

function M.code_action_fix_all()
  local context = { diagnostics = utils.get_current_line_diagnostics() }
  local params = vim.lsp.util.make_range_params()
  params.context = context
  vim.lsp.buf_request(
    0,
    "textDocument/codeAction",
    params,
    function(err, results_lsp)
      if err then
        vim.print(err)
        if err.message then
          vim.notify(err.message, vim.log.levels.ERROR)
        end
        return
      end
      if not results_lsp or vim.tbl_isempty(results_lsp) then
        print "No results from textDocument/codeAction"
        return
      end
      for _, result in pairs(results_lsp) do
        if
          result
          and result.command
          and result.command.command == "dart.edit.fixAll"
        then
          lsp_execute_command(result)
        end
      end
    end
  )
end

return M
