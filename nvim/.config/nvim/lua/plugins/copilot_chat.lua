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
      model = "claude-3.5-sonnet",
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
      mappings = {
        complete = {
          insert = "<M-CR>",
        },
      },
      prompts = {
        TranslateArb = {
          prompt = "Translate to language, specified in file name, translation is used in Flutter app, arb file.",
          description = "Translate arb file",
        },
        Commit = {
          prompt = "> #git:staged\n\nWrite commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. List message code as list - each sentence in new line. Be concise in explanation. Wrap the whole message in code block with language gitcommit. Use branch name as scope if branch name contains digits (i.e `ID-123`, `DNA-123`).",
        },
      },
    },
    keys = {
      {
        "<leader>pp",
        mode = { "n", "x" },
        "<Cmd>CopilotChatToggle<CR>",
        desc = "CopilotChat - Open",
      },
      {
        "<leader>pc",
        "<Cmd>CopilotChatCommit<CR>",
        desc = "CopilotChat - Commit",
      },
      {
        "<leader>pm",
        "<Cmd>CopilotChatModels<CR>",
        desc = "CopilotChat - Models",
      },
      {
        "<leader>pa",
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
