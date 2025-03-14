return {
  "sindrets/diffview.nvim",
  opts = {
    keymaps = {
      view = {
        { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close help menu" } },
      },
      file_panel = {
        { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close help menu" } },
      },
      file_history_panel = {
        { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close help menu" } },
      },
    },
    enhanced_diff_hl = true,
  },
  keys = {

    {
      "<leader>gd",
      function()
        if next(require("diffview.lib").views) == nil then
          vim.cmd "DiffviewOpen"
        else
          vim.cmd "DiffviewClose"
        end
      end,
      desc = "Open diffview",
    },
    {
      "<leader>gf",
      function()
        vim.cmd "DiffviewFileHistory %"
      end,
      desc = "Lazygit Current File History",
    },
  },
}
