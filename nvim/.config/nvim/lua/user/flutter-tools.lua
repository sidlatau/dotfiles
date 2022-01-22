
local status_ok, flutter_tools = pcall(require, "flutter-tools")
if not status_ok then return end

flutter_tools.setup({
    lsp = {
        on_attach = function(client, bufnr)
          require("lsp-status").on_attach(client)
          require("user.lsp.handlers").on_attach(client, bufnr)
        end,
        capabilities = require("user.lsp.handlers").capabilities
    },
    debugger = { -- integrate with nvim dap + install dart code debugger
      enabled = true,
      run_via_dap = true,
    },
    fvm = true,
    widget_guides = {
      enabled = true,
    },
  })
