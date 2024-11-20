return {
  -- "akinsho/flutter-tools.nvim",
  dir = "~/Documents/github/personal/flutter-tools.nvim",
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
          background_color = { r = 0, g = 0, b = 0 },
          foreground = false, -- highlight the foreground
          virtual_text = true, -- show the highlight using virtual text
          virtual_text_str = "■", -- the virtual text character to highlight
        },
        on_attach = function()
          vim.cmd "highlight FlutterWidgetGuides ctermfg=9 guifg=grey"
        end,
        settings = {
          renameFilesWithClasses = "always",
          analysisExcludedFolders = {
            ".dart_tool",
            "/Users/ts/.pub-cache/",
            "/Users/ts/fvm/",
          },
          completeFunctionCalls = true,
          experimentalRefactors = true,
          allowOpenUri = true,
        },
      },
      debugger = {
        enabled = true,
        -- don't pause on exception in flutter
        exception_breakpoints = {},
        -- register_configurations = function(_)
        --   require("dap").configurations.dart = {}
        --   require("dap.ext.vscode").load_launchjs()
        -- end,
      },
      fvm = true,
      widget_guides = {
        enabled = true,
      },
      dev_log = {
        enabled = true,
        open_cmd = "15split", -- command to use to open the log buffer
      },
      dev_tools = {
        autostart = false, -- autostart devtools server if not detected
        auto_open_browser = false, -- Automatically opens devtools in the browser
      },
      decorations = {
        statusline = {
          project_config = true,
        },
      },
    }
    require("telescope").load_extension "flutter"
  end,
  cond = function()
    return not vim.g.vscode
  end,
}
