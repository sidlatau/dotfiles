return {
  "nvim-flutter/flutter-tools.nvim",
  dev = true,
  event = "BufReadPre *.dart",
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
      outline = {
        auto_open = false,
      },
      debugger = {
        enabled = false,
        -- don't pause on exception in flutter
        exception_breakpoints = {},
        -- register_configurations = function(_)
        --   require("dap").configurations.dart = {
        --     {
        --       type = "dart",
        --       request = "launch",
        --       name = "Mobile",
        --       cwd = "${workspaceFolder}",
        --       program = "${workspaceFolder}/lib/main.dart",
        --     },
        --     {
        --       type = "dart",
        --       request = "launch",
        --       name = "Web",
        --       device = "chrome",
        --       cwd = "${workspaceFolder}",
        --       program = "${workspaceFolder}/lib/main.dart",
        --       args = {
        --         "--web-port",
        --         "4200",
        --         "-d",
        --         "chrome",
        --       },
        --     },
        --   }
        -- end,
      },
      fvm = true,
      widget_guides = {
        enabled = true,
      },
      dev_log = {
        enabled = true,
        open_cmd = "15split", -- command to use to open the log buffer
        notify_errors = true,
        focus_on_open = false,
        filter = function(str)
          local patterns = {
            "^I/MESA",
            "^W/o.handyhelp.app",
            "^D/nativeloader",
            "^W/pool",
            "^D/CompatChangeReporter",
            "^D/TrafficStats",
            "^E/Surface",
            "^D/ProfileInstaller",
            "^W/WindowOnBackDispatcher",
          }
          for _, pattern in ipairs(patterns) do
            if str and str:match(pattern) then
              return false
            end
          end
          return true
        end,
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
  keys = {
    {
      "<leader>fx",
      function()
        require("config.lsp.handlers").code_action_fix_all()
      end,
      desc = "Fix all",
    },
    {
      "<leader>fs",
      "<cmd>FlutterSuper<cr>",
      desc = "Flutter super",
    },
    {
      "<leader>fc",
      "<cmd>Telescope flutter commands<CR>",
      desc = "Commands list",
    },
    {
      "<leader>fl",
      "<cmd>FlutterLogToggle<CR>",
      desc = "Toggle log",
    },
    {
      "<leader>fe",
      "<cmd>FlutterEmulators<CR>",
      desc = "Emulators",
    },
    {
      "<leader>fr",
      "<cmd>FlutterRestart<CR>",
      desc = "Restart",
    },
    {
      "<leader>fB",
      "<cmd>TermExec cmd='fvm dart run build_runner build --delete-conflicting-outputs'<CR>",
      desc = "Run code generation",
    },
    {
      "<leader>fw",
      "<cmd>TermExec cmd='fvm dart run build_runner watch'<CR>",
      desc = "Watch code generation",
    },
    {
      "<leader>fb",
      function()
        require("config.toggleterm").regenerate_single_directory()
      end,
      desc = "Reneration single directory",
    },
    {
      "<leader>fg",
      "<cmd>FlutterPubGet<CR>",
      desc = "Flutter pub get",
    },
    {
      "<leader>fq",
      "<cmd>FlutterQuit<CR>",
      desc = "Flutter quit",
    },
    {
      "<leader>ff",
      "<cmd>FlutterDebug<CR>",
      desc = "Flutter run",
    },
    {
      "<leader>fz",
      "<cmd>FlutterLogClear<CR>",
      desc = "Flutter log clear",
    },
    {
      "<leader>fv",
      "<cmd>FlutterVisualDebug<CR>",
      desc = "Flutter visual debug",
    },
    {
      "<leader>fD",
      "<cmd>FlutterDevices<CR>",
      desc = "Flutter devices",
    },
    {
      "<leader>ftb",
      function()
        require("config.dart_mason").list_bricks()
      end,
      desc = "List bricks",
    },
    {
      "<leader>fd",
      "<cmd>DBUIToggle<cr>",
      desc = "DBUI",
    },
    {
      "<leader>fo",
      function()
        require("config.pick_db").open_simulator_db_connection()
      end,
      desc = "Add simulator DB connection",
    },
    {
      "<leader>fu",
      "<cmd>PubspecAssistPickVersion<cr>",
      desc = "Pubspec assist pick version",
    },
    {
      "<leader>fO",
      "<cmd>FlutterOutlineToggle<cr>",
      desc = "Toggle outline",
    },
  },
}
