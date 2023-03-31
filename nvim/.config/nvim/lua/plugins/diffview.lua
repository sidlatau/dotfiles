return {
  "sindrets/diffview.nvim",
  commit = "58035354fc79c6ec42fa7b218dab90bd3968615f",
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    require("diffview").setup {
      default_args = {
        DiffviewFileHistory = { "%" },
      },
      hooks = {
        diff_buf_read = function()
          vim.wo.wrap = false
          vim.wo.list = false
          vim.wo.colorcolumn = ""
        end,
      },
      enhanced_diff_hl = true,
      keymaps = {
        view = { q = "<Cmd>DiffviewClose<CR>" },
        file_panel = { q = "<Cmd>DiffviewClose<CR>" },
        file_history_panel = { q = "<Cmd>DiffviewClose<CR>" },
      },
    }
  end,
}
