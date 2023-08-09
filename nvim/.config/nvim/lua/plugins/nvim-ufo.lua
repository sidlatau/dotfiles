return {
  "kevinhwang91/nvim-ufo",
  event = "VeryLazy",
  dependencies = { "kevinhwang91/promise-async" },
  keys = {
    {
      "zR",
      function()
        require("ufo").openAllFolds()
      end,
      "open all folds",
    },
    {
      "zM",
      function()
        require("ufo").closeAllFolds()
      end,
      "close all folds",
    },
    {
      "zP",
      function()
        require("ufo").peekFoldedLinesUnderCursor()
      end,
      "preview fold",
    },
  },
  opts = function()
    require("ufo").setup {
      open_fold_hl_timeout = 0,
      preview = {
        win_config = { winhighlight = "Normal:Normal,FloatBorder:Normal" },
      },
      enable_get_fold_virt_text = true,
      close_fold_kinds = { "imports", "comment" },
    }
  end,
}
