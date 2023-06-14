return {
  "sidlatau/lsp-fastaction.nvim",
  -- dir = "~/Documents/github/personal/lsp-fastaction.nvim",
  event = "VeryLazy",
  config = function()
    require("lsp-fastaction").setup {
      hide_cursor = true,
      action_data = {
        --- action for filetype dart
        ["dart"] = {
          { pattern = "padding", key = "p", order = 2 },
          { pattern = "wrap with column", key = "c", order = 3 },
          { pattern = "wrap with row", key = "r", order = 3 },
          { pattern = "remove", key = "R", order = 5 },
          { pattern = "add", key = "a", order = 3 },
          { pattern = "import library 'package", key = "i", order = 3 },
          { pattern = "organize", key = "o", order = 3 },
          { pattern = "wrap with widget", key = "w", order = 2 },
          --range code action
          { pattern = "surround with %'if'", key = "i", order = 2 },
          { pattern = "try%-catch", key = "t", order = 2 },
          { pattern = "for%-in", key = "f", order = 2 },
          { pattern = "setstate", key = "s", order = 2 },
        },
      },
    }
  end,
}
