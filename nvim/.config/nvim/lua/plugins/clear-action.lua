return {
  "sidlatau/clear-action.nvim",
  dev = false,
  config = function()
    require("clear-action").setup {
      signs = { enable = false },
      mappings = {
        code_action = "<leader>a",
        apply_first = nil,
        quickfix = nil,
        quickfix_next = nil,
        quickfix_prev = nil,
        refactor = nil,
        refactor_inline = nil,
        refactor_extract = nil,
        refactor_rewrite = nil,
        source = nil,
        actions = {},
      },
      popup = { -- replaces the default prompt when selecting code actions
        enable = true,
        center = false,
        border = "rounded",
        hide_cursor = false,
        hide_client = false, -- hide displaying name of LSP client
        highlights = {
          header = "CodeActionHeader",
          label = "CodeActionLabel",
          title = "CodeActionTitle",
        },
      },
      action_labels = {
        ["dartls"] = {
          ["Wrap with widget..."] = "w",
          ["Wrap with Padding"] = "p",
          ["Wrap with Column"] = "c",
          ["Wrap with Row"] = "r",
          ["Wrap with Center"] = "C",
          ["Remove this widget"] = "R",
          ["Convert to block body"] = "c",
        },
      },
    }
  end,
}
