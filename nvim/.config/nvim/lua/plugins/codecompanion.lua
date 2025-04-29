return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/mcphub.nvim",
  },
  config = function()
    local spinner = require "config.codecompanion_spinner"
    spinner:init()
    require("codecompanion").setup {
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
            send = {
              callback = function(chat)
                vim.cmd "stopinsert"
                chat:add_buf_message { role = "llm", content = "" }
                chat:submit()
              end,
              index = 1,
              description = "Send",
            },
          },
        },
      },
    }
  end,
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
