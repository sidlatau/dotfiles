return {
  "tpope/vim-fugitive",
  event = "VeryLazy",
  dependencies = {
    "cedarbaum/fugitive-azure-devops.vim",
  },
  keys = {
    { "<leader>gc", "<cmd>0GBrowse!<cr>", desc = "Copy git url" },
    {
      "<leader>gs",
      ":0GBrowse!<cr>",
      desc = "Copy git url",
      mode = "x",
    },
  },
}
