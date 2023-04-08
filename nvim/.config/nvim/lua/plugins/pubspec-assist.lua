return {
  "akinsho/pubspec-assist.nvim",
  event = "VeryLazy",
  dependencies = "plenary.nvim",
  config = function()
    require("pubspec-assist").setup {}
  end,
}
