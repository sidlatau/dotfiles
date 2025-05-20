return {
  "sindrets/diffview.nvim",
  opts = {
    keymaps = {
      view = {
        { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close help menu" } },
      },
      file_panel = {
        { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close help menu" } },
        {
          "n",
          "cc",
          "<Cmd>Git commit <bar> wincmd J<CR>",
          { desc = "Commit staged changes" },
        },
        {
          "n",
          "ca",
          "<Cmd>Git commit --amend <bar> wincmd J<CR>",
          { desc = "Amend the last commit" },
        },
        {
          "n",
          "c<space>",
          ":Git commit ",
          { desc = 'Populate command line with ":Git commit "' },
        },
      },
      file_history_panel = {
        { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close help menu" } },
      },
    },
    view = {
      default = {
        layout = "diff2_vertical",
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
