return {
  "NeogitOrg/neogit",
  enable = false,
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "sindrets/diffview.nvim", -- optional - Diff integration

    -- Only one of these is needed.
    "nvim-telescope/telescope.nvim", -- optional
  },
  config = {
    graph_style = "kitty",
    process_spinner = true,
    disable_insert_on_commit = true,
  },
  keys = {
    {
      "<leader>gs",
      "<cmd>Neogit<CR>",
      desc = "Neogit - git client",
    },
  },
}
