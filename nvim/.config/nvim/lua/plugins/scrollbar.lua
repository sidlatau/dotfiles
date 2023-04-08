return {
  "petertriho/nvim-scrollbar",
  event = "VeryLazy",
  config = function()
    require("scrollbar").setup {
      handlers = {
        handle = false,
      },
      marks = {
        Cursor = { text = "" },
      },
    }
  end,
}
