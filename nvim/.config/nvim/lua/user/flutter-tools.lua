
local status_ok, flutter_tools = pcall(require, "flutter-tools")
if not status_ok then return end

flutter_tools.setup({
    lsp = {
          on_attach = function(client)
            print("Attached dart!")
            require("lsp-status").on_attach(client)
          end,
          capabilities = require("lsp-status").capabilities,
        },
    debugger = { -- integrate with nvim dap + install dart code debugger
      enabled = false,
    },
    fvm = true,
    widget_guides = {
      enabled = true,
    },
  })
