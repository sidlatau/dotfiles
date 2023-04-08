return {
  "andrewferrier/debugprint.nvim",
  event = "VeryLazy",
  config = function()
    require("debugprint").setup {
      print_tag = "D-->",
    }
  end,
}
