return {
  "lukas-reineke/lsp-format.nvim",
  event = "VeryLazy",
  config = function()
    require("lsp-format").setup {}
  end,
}
