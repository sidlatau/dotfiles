return {
  "andrewferrier/debugprint.nvim",
  config = function()
    require("debugprint").setup {
      print_tag = "D-->",
    }
  end,
}
