return {
  "sidlatau/pubspec-assist.nvim",
  branch = "sync-versions",
  dev = false,
  dependencies = "plenary.nvim",
  config = function()
    require("pubspec-assist").setup {}
  end,
}
