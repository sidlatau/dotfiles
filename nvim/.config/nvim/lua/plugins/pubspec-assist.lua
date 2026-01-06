return {
  "nvim-flutter/pubspec-assist.nvim",
  dev = true,
  dependencies = "plenary.nvim",
  config = function()
    require("pubspec-assist").setup {}
  end,
}
