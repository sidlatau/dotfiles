return {
  "nvim-treesitter/nvim-treesitter-context",
  config = function()
    require("treesitter-context").setup {
      max_lines = 1, -- How many lines the window should span. Values <= 0 mean no limit.
    }
  end,
}
