return {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  config = function()
    require("dressing").setup {
      input = {
        -- When true, <Esc> will close the modal
        insert_only = true,
        -- When true, input will start in insert mode.
        start_in_insert = true,
      },
    }
  end,
}
