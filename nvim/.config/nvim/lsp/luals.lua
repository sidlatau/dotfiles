return {
  capabilities = require("config.lsp.handlers").capabilities,
  root_dir = function()
    return vim.loop.cwd()
  end,
  settings = {
    Lua = {
      codeLens = { enable = true },
      hint = {
        enable = true,
        arrayIndex = "Disable",
        setType = true,
        paramName = "Disable",
      },
      format = { enable = false },
      diagnostics = {
        globals = { "describe", "it", "before_each", "after_each", "Snacks" },
      },
      completion = { keywordSnippet = "Replace", callSnippet = "Replace" },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}
