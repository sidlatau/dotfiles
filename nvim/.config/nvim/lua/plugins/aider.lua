return {
  "GeorgesAlkhouri/nvim-aider",
  cmd = "Aider",
  opts = {
    auto_reload = true,
    picker_cfg = {
      preset = "select",
    },
  },
  keys = {
    { "<leader><tab><tab>", "<cmd>Aider toggle<cr>", desc = "Toggle Aider" },
    {
      "<leader><tab>s",
      "<cmd>Aider send<cr>",
      desc = "Send to Aider",
      mode = { "n", "v" },
    },
    { "<leader><tab>c", "<cmd>Aider command<cr>", desc = "Aider Commands" },
    { "<leader><tab>b", "<cmd>Aider buffer<cr>", desc = "Send Buffer" },
    { "<leader><tab>+", "<cmd>Aider add<cr>", desc = "Add File" },
    { "<leader><tab>-", "<cmd>Aider drop<cr>", desc = "Drop File" },
    { "<leader><tab>r", "<cmd>Aider add readonly<cr>", desc = "Add Read-Only" },
    { "<leader><tab>R", "<cmd>Aider reset<cr>", desc = "Reset Session" },
    {
      "<leader><tab>a",
      function()
        local api = require("nvim_aider").api
        vim.ui.input({ prompt = "Ask (empty to skip):" }, function(input)
          if input ~= nil then
            if input ~= "" then
              api.send_command("/ask", input)
            end
          end
        end)
      end,
      desc = "Ask",
    },
  },
  dependencies = {
    "folke/snacks.nvim",
  },
  config = true,
}
