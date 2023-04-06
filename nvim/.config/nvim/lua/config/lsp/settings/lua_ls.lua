local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
return {
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
        globals = { "vim" },
      },
      completion = { keywordSnippet = "Replace", callSnippet = "Replace" },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}
