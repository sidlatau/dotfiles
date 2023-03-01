return {
  "akinsho/pubspec-assist.nvim",
  dependencies = "plenary.nvim",
  config = function()
    require("pubspec-assist").setup {}
  end,
}
