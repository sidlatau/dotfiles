return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/mcphub.nvim",
  },
  opts = {
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          make_vars = true,
          make_slash_commands = true,
          show_result_in_chat = true,
        },
      },
    },
  },
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
