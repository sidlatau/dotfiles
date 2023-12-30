return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  config = function()
    require("dashboard").setup {
      shortcut_type = "number",
      config = {
        week_header = {
          enable = true,
        },
        project = { enable = false },
        mru = {
          limit = 5,
          cwd_only = true,
        },
        footer = {},
        shortcut = {
          { desc = "[  Github]", group = "DashboardShortCut" },
        },
      },
    }
  end,
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
