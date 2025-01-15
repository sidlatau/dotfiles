return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
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
          prompt = "Translate to language, specified in file name, translation is used in Flutter app, arb file. Do not add any explanatory comments. Include lines that are already translated, for ability to safely replace output.",
          description = "Translate arb file",
        },
        Commit = {
          prompt = "> #git:staged\n\nWrite commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. List message code as list - each sentence in new line. Be concise in explanation. Wrap the whole message in code block with language gitcommit. Use branch name as scope if branch name contains digits (i.e `ID-123`, `DNA-123`).",
        },
        ReviewStaged = {
          prompt = "> /COPILOT_REVIEW\n\n#git:staged\n\n Review the staged code. Show link to file and line number. If there are multiple lines, show the range. If there are multiple files, show the file name.",
          callback = function(response, source)
            local diagnostics = {}
            for line in response:gmatch "[^\r\n]+" do
              if line:find "^line=" then
                local start_line = nil
                local end_line = nil
                local message = nil
                local single_match, message_match =
                  line:match "^line=(%d+): (.*)$"
                if not single_match then
                  local start_match, end_match, m_message_match =
                    line:match "^line=(%d+)-(%d+): (.*)$"
                  if start_match and end_match then
                    start_line = tonumber(start_match)
                    end_line = tonumber(end_match)
                    message = m_message_match
                  end
                else
                  start_line = tonumber(single_match)
                  end_line = start_line
                  message = message_match
                end

                if start_line and end_line then
                  table.insert(diagnostics, {
                    lnum = start_line - 1,
                    end_lnum = end_line - 1,
                    col = 0,
                    message = message,
                    severity = vim.diagnostic.severity.WARN,
                    source = "Copilot Review",
                  })
                end
              end
            end
            vim.diagnostic.set(
              vim.api.nvim_create_namespace "copilot_diagnostics",
              source.bufnr,
              diagnostics
            )
          end,
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
