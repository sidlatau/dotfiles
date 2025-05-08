return {
  "GeorgesAlkhouri/nvim-aider",
  cmd = "Aider",
  -- Example key mappings for common actions:
  keys = {
    { "<leader>AA", "<cmd>Aider toggle<cr>", desc = "Toggle Aider" },
    {
      "<leader>As",
      "<cmd>Aider send<cr>",
      desc = "Send to Aider",
      mode = { "n", "v" },
    },
    { "<leader>Ac", "<cmd>Aider command<cr>", desc = "Aider Commands" },
    { "<leader>Ab", "<cmd>Aider buffer<cr>", desc = "Send Buffer" },
    { "<leader>A+", "<cmd>Aider add<cr>", desc = "Add File" },
    { "<leader>A-", "<cmd>Aider drop<cr>", desc = "Drop File" },
    { "<leader>Ar", "<cmd>Aider add readonly<cr>", desc = "Add Read-Only" },
    { "<leader>AR", "<cmd>Aider reset<cr>", desc = "Reset Session" },
  },
  dependencies = {
    "folke/snacks.nvim",
  },
  config = true,
}
