return {
  -- "akinsho/pubspec-assist.nvim",
  "sidlatau/pubspec-assist.nvim",
  -- dir = "~/Documents/github/personal/pubspec-assist.nvim",
  event = "VeryLazy",
  dependencies = "plenary.nvim",
  config = function()
    require("pubspec-assist").setup {}
  end,
}
