return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/mcphub.nvim",
  },
  opts = {
    adapters = {
      copilot = function()
        return require("codecompanion.adapters").extend("copilot", {
          schema = {
            model = {
              default = "claude-3.7-sonnet",
            },
          },
        })
      end,
    },
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
    strategies = {
      chat = {
        keymaps = {
          close = {
            modes = { n = "q", i = "<C-c>" },
          },
          stop = {
            modes = { n = "<C-l>" },
          },
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
