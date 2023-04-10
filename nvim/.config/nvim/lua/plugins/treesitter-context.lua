return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "VeryLazy",
  config = function()
    require("treesitter-context").setup {
      multiline_threshold = 4,
      separator = { "─", "WinSeparator" }, -- alternatives: ▁ ─ ▄
      mode = "cursor",
    }
  end,
}
