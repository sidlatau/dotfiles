return {
  "windwp/nvim-autopairs",
  event = "VeryLazy",
  config = function()
    local autopairs = require "nvim-autopairs"
    local Rule = require "nvim-autopairs.rule"
    autopairs.setup {
      check_ts = true,
      ts_config = {
        lua = { "string" },
        dart = { "string" },
        javascript = { "template_string" },
      },
      disable_filetype = { "TelescopePrompt" },
    }
    -- autopairs.disable()
    -- credit: https://github.com/JoosepAlviste
    -- Typing = when () -> () => {|}
    autopairs.add_rules {
      Rule(
        "%(.*%)%s*%=$",
        "> {}",
        { "typescript", "typescriptreact", "javascript", "vue" }
      ):use_regex(true):set_end_pair_length(1),
      -- Typing n when the| -> then|end
      Rule("then", "end", "lua"):end_wise(function(opts)
        return string.match(opts.line, "^%s*if") ~= nil
      end),
    }

    local cmp_autopairs = require "nvim-autopairs.completion.cmp"
    local handlers = require "nvim-autopairs.completion.handlers"
    local cmp_status_ok, cmp = pcall(require, "cmp")
    if not cmp_status_ok then
      return
    end
    cmp.event:on(
      "confirm_done",
      cmp_autopairs.on_confirm_done {
        filetypes = {
          -- "*" is a alias to all filetypes
          ["*"] = {
            ["("] = {
              kind = {
                cmp.lsp.CompletionItemKind.Function,
                cmp.lsp.CompletionItemKind.Method,
              },
              handler = handlers["*"],
            },
          },
        },
      }
    )
  end,
}
