local status_ok, flutter_tools = pcall(require, "flutter-tools")
if not status_ok then
  return
end

flutter_tools.setup {
  lsp = {
    on_attach = function(client, bufnr)
      require("lsp-status").on_attach(client)
      require("user.lsp.handlers").on_attach(client, bufnr)
    end,
    capabilities = require("user.lsp.handlers").capabilities,
    settings = {
      analysisExcludedFolders = {
        ".dart_tool",
        "/Users/ts/.pub-cache/hosted/",
        "/Users/ts/fvm/",
      },
    },
  },
  debugger = { -- integrate with nvim dap + install dart code debugger
    enabled = true,
    run_via_dap = true,
  },
  fvm = true,
  widget_guides = {
    enabled = true,
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