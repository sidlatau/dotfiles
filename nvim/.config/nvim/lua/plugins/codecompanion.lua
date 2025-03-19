return {
  "olimorris/codecompanion.nvim",
  config = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {},
  keys = {
    {
      "<leader>pP",
      mode = { "n", "x" },
      "<Cmd>CodeCompanionChat Toggle<CR>",
      desc = "Code companion chat toggle",
    },
    {
      "<leader>pA",
      mode = { "n", "x" },
      "<Cmd>CodeCompanionActions<CR>",
      desc = "Code companion chat actions",
    },
  },
}
