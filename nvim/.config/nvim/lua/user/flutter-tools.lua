
local status_ok, flutter_tools = pcall(require, "flutter-tools")
if not status_ok then return end

flutter_tools.setup({
    lsp = {
        on_attach = require("user.lsp.handlers").on_attach,
        capabilities = require("user.lsp.handlers").capabilities
    },
    debugger = { -- integrate with nvim dap + install dart code debugger
      enabled = false,
    },
    fvm = true,
    widget_guides = {
      enabled = true,
    },
  })
