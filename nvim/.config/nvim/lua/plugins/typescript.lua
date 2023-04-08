return {
  "jose-elias-alvarez/typescript.nvim",
  config = function()
    require("typescript").setup {
      server = { -- pass options to lspconfig's setup method
        on_attach = require("config.lsp.handlers").on_attach,
        capabilities = require("config.lsp.handlers").capabilities,
      },
    }
  end,
}
