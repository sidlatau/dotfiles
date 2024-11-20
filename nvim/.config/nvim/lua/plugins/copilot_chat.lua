return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      highlight_headers = false,
      separator = "---",
      error_header = "> [!ERROR] Error",
    },
    keys = {
      {
        "<leader>op",
        "<Cmd>CopilotChatOpen<CR>",
        desc = "CopilotChat - Open",
      },
      {
        "<leader>oq",
        function()
          local input = vim.fn.input "Quick Chat: "
          if input ~= "" then
            require("CopilotChat").ask(
              input,
              { selection = require("CopilotChat.select").buffer }
            )
          end
        end,
        desc = "CopilotChat - Quick chat",
      },
    },
  },
}
