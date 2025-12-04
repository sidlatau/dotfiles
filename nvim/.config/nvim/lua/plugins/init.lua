return {
  { "nvim-lua/popup.nvim", event = "VeryLazy" },
  { "nvim-lua/plenary.nvim", event = "VeryLazy" },
  { "kyazdani42/nvim-web-devicons", event = "VeryLazy" },
  { "JoosepAlviste/nvim-ts-context-commentstring", event = "VeryLazy" },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },
  { "tpope/vim-sleuth", event = "VeryLazy" },
  { "tpope/vim-repeat", event = "VeryLazy" },
  { "tpope/vim-projectionist", event = "VeryLazy" },
  { "tpope/vim-unimpaired", event = "VeryLazy" },

  { "neovim/nvim-lspconfig", event = "VeryLazy" },
  { "williamboman/mason.nvim", event = "VeryLazy" },
  { "williamboman/mason-lspconfig.nvim", event = "VeryLazy" },
  { "nvim-treesitter/nvim-treesitter-textobjects", event = "VeryLazy" },
  { "nvim-telescope/telescope-dap.nvim", event = "VeryLazy" },
  { "milch/vim-fastlane", event = "VeryLazy" },
  { "delphinus/vim-firestore", event = "VeryLazy" },
  { "tpope/vim-rhubarb", event = "VeryLazy" },
  { "tpope/vim-abolish", event = "VeryLazy" },
  { "mtdl9/vim-log-highlighting", event = "VeryLazy" },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    event = "VeryLazy",
    build = "make",
  },
  { "whiteinge/diffconflicts" },
  { "wsdjeg/vim-fetch", event = "VeryLazy" },
  { "smartpde/telescope-recent-files", event = "VeryLazy" },
  { "mbbill/undotree", event = "VeryLazy" },
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
  },
  {
    "sidlatau/dart-lsp-refactorings.nvim",
    event = "VeryLazy",
  },
  { "akinsho/git-conflict.nvim", version = "*", config = true },
  {
    "sidlatau/neotest-dart",
    dir = "~/Documents/github/personal/neotest-dart",
  },
  { "tpope/vim-dadbod" },
  {
    "aaronhallaert/advanced-git-search.nvim",
  },
  {
    "wakatime/vim-wakatime",
  },
  { "b0o/schemastore.nvim" },
  { "rose-pine/neovim", name = "rose-pine" },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      file_types = { "markdown", "copilot-chat" },
    },
  },
  {
    "seblj/roslyn.nvim",
    ft = "cs",
    opts = {},
  },
  {
    "Cliffback/netcoredbg-macOS-arm64.nvim",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("netcoredbg-macOS-arm64").setup(require "dap")
    end,
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    config = function()
      require("tiny-inline-diagnostic").setup()
    end,
  },
  {
    "nvim-mini/mini.diff",
    version = "*",
    opts = {},
    keys = {
      {
        "<leader>gt",
        function()
          require("mini.diff").enable(0)
          require("mini.diff").toggle_overlay(0)
        end,
        desc = "Toggle mini.diff overlay",
      },
    },
  },
  {
    "sourcegraph/amp.nvim",
    branch = "main",
    lazy = false,
    opts = { auto_start = true, log_level = "info" },
  },
}
