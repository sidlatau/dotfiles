return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "sindrets/diffview.nvim", -- optional - Diff integration

    -- Only one of these is needed, not both.
    "nvim-telescope/telescope.nvim", -- optional
    "ibhagwan/fzf-lua", -- optional
  },
  config = {
    git_services = {
      ["azure.com"] = "https://dev.azure.com/devincodev/mobile/_git/${repository}/pullrequestcreate?sourceRef=${branch_name}",
    },
  },
}
