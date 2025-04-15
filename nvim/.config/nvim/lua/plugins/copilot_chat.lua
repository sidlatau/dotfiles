local MODIFIED_COPILOT_BASE = string.format(
  [[
When asked for your name, you must respond with "GitHub Copilot".
Follow the user's requirements carefully & to the letter.
Follow Microsoft content policies.
Avoid content that violates copyrights.
If you are asked to generate content that is harmful, hateful, racist, sexist, lewd, violent, or completely irrelevant to software engineering, only respond with "Sorry, I can't assist with that."
Keep your answers short and impersonal.
The user works in an IDE called Neovim which has a concept for editors with open files, integrated unit test support, an output pane that shows the output of running the code as well as an integrated terminal.
The user is working on a %s machine. Please respond with system specific commands if applicable.
You will receive code snippets that include line number prefixes - use these to maintain correct position references but remove them when generating output.

When presenting code changes:

1. For each change, first provide a header outside code blocks with format:
   [file:<file_name>](<file_path>) line:<start_line>-<end_line>

2. Then wrap the actual code in triple backticks with the appropriate language identifier.

3. Keep changes minimal and focused to produce short diffs.

4. Include complete replacement code for the specified line range with:
   - Proper indentation matching the source
   - All necessary lines (no eliding with comments)
   - No line number prefixes in the code

5. Address any diagnostics issues when fixing code.

6. If multiple changes are needed, present them as separate blocks with their own headers.

7. Check line numbers in proposed changes again. Check for one-off line number errors.
]],
  vim.uv.os_uname().sysname
)

local COPILOT_INSTRUCTIONS = [[
You are a code-focused AI programming assistant that specializes in practical software engineering solutions.
]] .. MODIFIED_COPILOT_BASE

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
      model = "claude-3.7-sonnet",
      highlight_headers = false,
      separator = "---",
      error_header = "> [!ERROR] Error",
      mappings = {
        complete = {
          insert = "<M-CR>",
        },
        show_diff = {
          normal = "gsd",
          full_diff = true, -- Show full diff instead of unified diff when showing diff window
        },
      },
      sticky = {
        "#buffer",
        "/my_instructions",
      },
      prompts = {
        my_instructions = {
          system_prompt = COPILOT_INSTRUCTIONS,
        },
        TranslateArb = {
          prompt = "Translate to language, specified in file name, translation is used in Flutter app, arb file. Do not add any explanatory comments. Include lines that are already translated, for ability to safely replace output.",
          description = "Translate arb file",
        },
        Commit = {
          prompt = "> #git:staged\n\nWrite commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. If change is not obvious or bigger than 3 files, shortly explain key changes as bullet list. Be concise in explanation, do not repeat same information as in message header. Empty description is also OK. Wrap the whole message in code block with language gitcommit. Use branch name as scope if branch name contains digits (i.e `ID-123`, `DNA-123`).",
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
          require("CopilotChat").select_prompt {}
        end,
        desc = "CopilotChat - Prompt actions",
      },
      {
        "<leader>§",
        function()
          Snacks.input.input({ prompt = "Quick Chat: " }, function(input)
            if input ~= "" then
              require("CopilotChat").ask(
                input,
                { selection = require("CopilotChat.select").buffer }
              )
            end
          end)
        end,
        desc = "CopilotChat - Quick chat",
      },
      {
        "<leader>§",
        mode = { "x" },
        function()
          Snacks.input.input({ prompt = "Quick Chat: " }, function(input)
            if input ~= "" then
              require("CopilotChat").ask(
                input,
                { selection = require("CopilotChat.select").visual }
              )
            end
          end)
        end,
        desc = "CopilotChat - Quick chat",
      },
    },
  },
}
