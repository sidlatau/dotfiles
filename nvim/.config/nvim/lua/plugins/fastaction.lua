return {
  "Chaitanyabsprip/fastaction.nvim",
  ---@type FastActionConfig
  opts = {
    dismiss_keys = { "j", "k", "<c-c>", "<esc>" },
    keys = "qwertyuiopasdfghlzxcvbnmQWERTYUIOPASDFGHLZXCVBNM",
    register_ui_select = false,
    priority = {
      dart = {
        { pattern = "wrap with widget", key = "w", order = 1 },
        { pattern = "padding", key = "p", order = 2 },
        { pattern = "column", key = "c", order = 3 },
        { pattern = "row", key = "r", order = 3 },
        { pattern = "center", key = "C", order = 4 },
        { pattern = "remove this widget", key = "R", order = 5 },
        { pattern = "convert to block body", key = "c", order = 6 },
        { pattern = "expression", key = "c", order = 7 },
        { pattern = "unawaited", key = "w", order = 7 },
      },
    },
  },
  keys = {
    {
      "<leader>a",
      '<cmd>lua require("fastaction").code_action()<CR>',
      desc = "Lsp code action",
      mode = { "n", "x" },
    },
  },
}
