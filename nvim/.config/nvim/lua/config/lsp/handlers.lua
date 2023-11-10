local M = {}

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
    virtual_text = false and {
      prefix = "●",
      source = "always",
    },
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

  vim.lsp.handlers["textDocument/hover"] = function(...)
    local hover_handler = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
    })
    vim.b.lsp_hover_buf, vim.b.lsp_hover_win = hover_handler(...)
  end

  vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = "rounded",
    })
end

local function lsp_highlight_document(client, bufnr)
  -- Set autocommands conditional on server_capabilities
  if client and client.server_capabilities.codeLensProvider then
    local codelens_highlight = vim.api.nvim_create_augroup("LspCodeLens", {})
    vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
      group = codelens_highlight,
      buffer = bufnr,
      callback = function()
        vim.lsp.codelens.refresh()
      end,
    })
  end
  if client.server_capabilities.documentHighlightProvider then
    local lsp_document_highlight =
      vim.api.nvim_create_augroup("lsp_document_highlight", {})
    vim.api.nvim_create_autocmd({ "CursorHold" }, {
      group = lsp_document_highlight,
      buffer = bufnr,
      callback = function(args)
        if
          vim.b.lsp_hover_win and vim.api.nvim_win_is_valid(vim.b.lsp_hover_win)
        then
          return
        end
        vim.diagnostic.open_float(args.buf, { scope = "line", focus = false })
      end,
    })
  end
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
  vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, opts)
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
end

M.on_attach = function(client, bufnr)
  if client.name == "tsserver" or client.name == "lua_ls" then
    -- do not format by this LSP - prettier is used for formatting
    client.server_capabilities.documentFormattingProvider = false
  end
  lsp_keymaps(bufnr)
  lsp_highlight_document(client, bufnr)
  local ok, lsp_format = pcall(require, "lsp-format")
  if ok and client.name ~= "dartls" then
    lsp_format.on_attach(client)
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local cmp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_status_ok then
  return
end

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

local function lsp_execute_command(val)
  if val.edit or type(val.command) == "table" then
    if val.edit then
      vim.lsp.util.apply_workspace_edit(val.edit, "utf-8")
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
