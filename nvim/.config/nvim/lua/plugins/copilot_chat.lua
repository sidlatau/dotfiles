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
      callback = function(result)
        local lines = vim.split(result, "\n")
        table.remove(lines, 1) -- Remove the first line
        table.remove(lines) -- Remove the last line
        local new_result = table.concat(lines, "\n")
        vim.fn.setreg("+", new_result) -- Copy to system clipboard
      end,
    },
    keys = {
      {
        "<leader>op",
        "<Cmd>CopilotChatOpen<CR>",
        desc = "CopilotChat - Open",
      },
      {
        "<leader>oc",
        "<Cmd>CopilotChatCommit<CR>",
        desc = "CopilotChat - Commit",
      },
      {
        "<leader>om",
        "<Cmd>CopilotChatModels<CR>",
        desc = "CopilotChat - Models",
      },
      {
        "<leader>oa",
        mode = { "n", "x" },
        function()
          local actions = require "CopilotChat.actions"
          require("CopilotChat.integrations.telescope").pick(
            actions.prompt_actions()
          )
        end,
        desc = "CopilotChat - Prompt actions",
      },
    },
  },
}
