return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  build = "make lua51",
  opts = {
    provider = "copilot",
    mappings = {
      ask = "<d-a>a",
      edit = "<d-a>e",
      refresh = "<d-a>r",
      -- --- @class AvanteConflictMappings
      -- diff = {
      --   ours = "co",
      --   theirs = "ct",
      --   none = "c0",
      --   both = "cb",
      --   next = "]x",
      --   prev = "[x",
      -- },
      -- jump = {
      --   next = "]]",
      --   prev = "[[",
      -- },
    },
    hints = { enabled = false },
    behaviour = {
      cycle_between_open_buffers = false,
      auto_apply_diff_after_generation = true,
    },
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    {
      "grapp-dev/nui-components.nvim",
      dependencies = {
        "MunifTanjim/nui.nvim",
      },
    },
    --- The below is optional, make sure to setup it properly if you have lazy=true
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
