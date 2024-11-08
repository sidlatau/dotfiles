return {
  { "nvim-lua/popup.nvim", event = "VeryLazy" },
  { "nvim-lua/plenary.nvim", event = "VeryLazy" },
  { "kyazdani42/nvim-web-devicons", event = "VeryLazy" },
  { "JoosepAlviste/nvim-ts-context-commentstring", event = "VeryLazy" },
  {
    "echasnovski/mini.surround",
    version = false,
    config = function()
      require("mini.surround").setup()
    end,
  },
  { "tpope/vim-sleuth", event = "VeryLazy" },
  { "tpope/vim-repeat", event = "VeryLazy" },
  { "tpope/vim-projectionist", event = "VeryLazy" },
  { "tpope/vim-unimpaired", event = "VeryLazy" },

  { "hrsh7th/cmp-buffer", event = "VeryLazy" },
  { "hrsh7th/cmp-path", event = "VeryLazy" },
  { "hrsh7th/cmp-cmdline", event = "VeryLazy" },
  { "saadparwaiz1/cmp_luasnip", event = "VeryLazy" },
  { "hrsh7th/cmp-nvim-lsp", event = "VeryLazy" },
  { "hrsh7th/cmp-nvim-lua", event = "VeryLazy" },
  { "hrsh7th/cmp-nvim-lsp-document-symbol", event = "VeryLazy" },
  { "ThePrimeagen/harpoon", event = "VeryLazy" },

  { "neovim/nvim-lspconfig", event = "VeryLazy" },
  { "williamboman/mason.nvim", event = "VeryLazy" },
  { "williamboman/mason-lspconfig.nvim", event = "VeryLazy" },
  { "nvim-treesitter/nvim-treesitter-textobjects", event = "VeryLazy" },
  { "nvim-telescope/telescope-dap.nvim", event = "VeryLazy" },
  { "vim-scripts/BufOnly.vim", event = "VeryLazy" },
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
  { "RRethy/vim-illuminate", event = "VeryLazy" },
  {
    "sidlatau/dart-lsp-refactorings.nvim",
    event = "VeryLazy",
  },
  { "akinsho/git-conflict.nvim", version = "*", config = true },
  {
    "sidlatau/neotest-dart",
    -- dir = "~/Documents/github/personal/neotest-dart",
  },
  { "tpope/vim-dadbod" },
  {
    "aaronhallaert/advanced-git-search.nvim",
  },
  {
    "wakatime/vim-wakatime",
  },
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {
      disable_mouse = false,
      max_count = 15,
      restriction_mode = "hint",
      restricted_keys = {
        ["<C-N>"] = {},
        ["<C-P>"] = {},
      },
      disabled_keys = {
        ["<Up>"] = { "" },
        ["<Down>"] = { "" },
        ["<Left>"] = { "" },
        ["<Right>"] = { "" },
      },
    },
  },
  { "b0o/schemastore.nvim" },
  { "rose-pine/neovim", name = "rose-pine" },
  {
    "3rd/image.nvim",
    opts = {},
  },
}
