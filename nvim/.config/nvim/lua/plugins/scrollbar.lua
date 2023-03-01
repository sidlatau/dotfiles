return {
  "petertriho/nvim-scrollbar",
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
