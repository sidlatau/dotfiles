return {
  capabilities = require("config.lsp.handlers").capabilities,
  settings = {
    yaml = {
      completion = true,
      validate = true,
      schemaStore = {
        enable = true,
        url = "https://www.schemastore.org/api/json/catalog.json",
      },
    },
  },
}
