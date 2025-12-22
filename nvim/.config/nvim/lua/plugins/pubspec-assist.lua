return {
  "nvim-flutter/pubspec-assist.nvim",
  dev = true,
  -- event = "VeryLazy",
  dependencies = "plenary.nvim",
  config = function()
    require("pubspec-assist").setup {}
  end,
}
