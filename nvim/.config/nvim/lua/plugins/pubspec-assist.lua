return {
  "nvim-flutter/pubspec-assist.nvim",
  dev = false,
  -- event = "VeryLazy",
  dependencies = "plenary.nvim",
  config = function()
    require("pubspec-assist").setup {}
  end,
}
