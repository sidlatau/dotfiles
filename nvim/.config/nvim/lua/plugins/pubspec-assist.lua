return {
  "nvim-flutter/pubspec-assist.nvim",
  dev = false,
  dependencies = "plenary.nvim",
  config = function()
    require("pubspec-assist").setup {}
  end,
}
