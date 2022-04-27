local status_ok, flutter_tools = pcall(require, "flutter-tools")
if not status_ok then
  return
end

flutter_tools.setup {
  ui = {
    notification_style = "native",
  },
  lsp = {
    color = { -- show the derived colours for dart variables
      enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
      background = false, -- highlight the background
      foreground = false, -- highlight the foreground
      virtual_text = true, -- show the highlight using virtual text
      virtual_text_str = "■", -- the virtual text character to highlight
    },
    on_attach = function(client, bufnr)
      require("user.lsp.handlers").on_attach(client, bufnr)
      vim.cmd "highlight FlutterWidgetGuides ctermfg=9 guifg=grey"
    end,
    capabilities = require("user.lsp.handlers").capabilities,
    settings = {
      renameFilesWithClasses = "always",
      analysisExcludedFolders = {
        ".dart_tool",
        "/Users/ts/.pub-cache/",
        "/Users/ts/fvm/",
      },
    },
  },
  debugger = { -- integrate with nvim dap + install dart code debugger
    enabled = true,
    run_via_dap = true,
    -- Not used yet
    -- register_configurations = function(paths)
    --   require("dap").configurations.dart = {
    --     {
    --       type = "dart",
    --       request = "launch",
    --       name = "Launch flutter",
    --       dartSdkPath = paths.dart_sdk,
    --       flutterSdkPath = paths.flutter_sdk,
    --       program = "${workspaceFolder}/lib/main.dart",
    --       cwd = "${workspaceFolder}",
    --     },
    --     {
    --       type = "dart",
    --       request = "launch",
    --       name = "Test flutter",
    --       dartSdkPath = paths.dart_sdk,
    --       flutterSdkPath = paths.flutter_sdk,
    --       program = "${file}",
    --       cwd = "${workspaceFolder}",
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
  },
}

local api = vim.api
local M = {}

M.toggle_log = function()
  local wins = api.nvim_list_wins()

  for _, id in pairs(wins) do
    local bufnr = api.nvim_win_get_buf(id)
    if
      api.nvim_buf_get_name(bufnr):match ".*/([^/]+)$" == "__FLUTTER_DEV_LOG__"
    then
      return vim.api.nvim_win_close(id, true)
    end
  end

  pcall(function()
    vim.api.nvim_command "sb + __FLUTTER_DEV_LOG__ | resize 15"
  end)
end

return M
