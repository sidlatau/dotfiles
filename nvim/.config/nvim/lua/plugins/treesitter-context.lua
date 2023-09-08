return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "VeryLazy",
  enabled = false,
  config = function()
    require("treesitter-context").setup {}
  end,
}
