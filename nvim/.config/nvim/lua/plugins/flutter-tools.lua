return {
  "akinsho/flutter-tools.nvim",
  -- branch = "feature/deprecate-custom-notify",
  -- dir = "~/Documents/github/personal/flutter-tools.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    local flutter_tools = require "flutter-tools"
    flutter_tools.setup {
      ui = {
        notification_style = "native",
      },
      lsp = {
        color = { -- show the derived colours for dart variables
          enabled = true,
          background = false, -- highlight the background
          foreground = false, -- highlight the foreground
          virtual_text = true, -- show the highlight using virtual text
          virtual_text_str = "■", -- the virtual text character to highlight
        },
        on_attach = function(client, bufnr)
          require("user.lsp.handlers").on_attach(client, bufnr)
          vim.cmd "highlight FlutterWidgetGuides ctermfg=9 guifg=grey"
        end,
        settings = {
          renameFilesWithClasses = "always",
          analysisExcludedFolders = {
            ".dart_tool",
            "/Users/ts/.pub-cache/",
            "/Users/ts/fvm/",
          },
          updateImportsOnRename = true,
          completeFunctionCalls = true,
        },
      },
      debugger = {
        enabled = true,
        run_via_dap = true,
        -- don't pause on exception in flutter
        exception_breakpoints = {},
      },
      fvm = true,
      widget_guides = {
        enabled = true,
      },
      dev_log = {
        enabled = true,
        open_cmd = "15split", -- command to use to open the log buffer
      },
    }
  end,
  cond = function()
    return not vim.g.vscode
  end,
}
