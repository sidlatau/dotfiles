local M = {}

vim.cmd [[
highlight DiagnosticUnderlineError guifg=Red ctermfg=Red
hi DiagnosticError guifg=Red ctermfg=Red
]]

M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(
      sign.name,
      { texthl = sign.name, text = sign.text, numhl = "" }
    )
  end

  local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
    })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    {
      border = "rounded",
    }
  )
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightProvider then
    local lsp_document_highlight = vim.api.nvim_create_augroup(
      "lsp_document_highlight",
      {}
    )
    vim.api.nvim_create_autocmd({ "CursorHold" }, {
      group = lsp_document_highlight,
      pattern = "<buffer>",
      callback = function()
        vim.lsp.buf.document_highlight()
      end,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved" }, {
      group = lsp_document_highlight,
      pattern = "<buffer>",
      callback = function()
        vim.lsp.buf.clear_references()
      end,
    })
  end
end

local function lsp_keymaps(bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local opts = { buffer = bufnr, silent = true }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "gr", function()
    require("telescope.builtin").lsp_references(
      require("telescope.themes").get_dropdown {
        layout_config = { width = 0.8 },
      }
    )
  end, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
end

M.on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    client.server_capabilities.document_formatting = false
    local ts_utils = require "nvim-lsp-ts-utils"
    ts_utils.setup {
      filter_out_diagnostics_by_code = { 80001 },
    }
    -- required to fix code action ranges and filter diagnostics
    ts_utils.setup_client(client)

    -- no default maps, so you may want to define some here
    local opts = { silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
    vim.api.nvim_buf_set_keymap(
      bufnr,
      "n",
      "<leader>lr",
      ":TSLspRenameFile<CR>",
      opts
    )
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", opts)
  end
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
  local ok, lsp_format = pcall(require, "lsp-format")
  if ok then
    lsp_format.on_attach(client)
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local cmp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_status_ok then
  return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

local function lsp_execute_command(val)
  if val.edit or type(val.command) == "table" then
    if val.edit then
      vim.lsp.util.apply_workspace_edit(val.edit)
    end
    if type(val.command) == "table" then
      vim.lsp.buf.execute_command(val.command)
    end
  else
    vim.lsp.buf.execute_command(val)
  end
end

function M.code_action_fix_all()
  local context = { diagnostics = vim.lsp.diagnostic.get_line_diagnostics() }
  local params = vim.lsp.util.make_range_params()
  params.context = context
  vim.lsp.buf_request(
    0,
    "textDocument/codeAction",
    params,
    function(err, results_lsp)
      if err then
        vim.pretty_print(err)
        if err.message then
          vim.notify(err.message, "error")
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
          and result.command.command == "edit.fixAll"
        then
          lsp_execute_command(result)
        end
      end
    end
  )
end

return M
