return {
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  "kyazdani42/nvim-web-devicons",
  "moll/vim-bbye",
  "JoosepAlviste/nvim-ts-context-commentstring",
  "tpope/vim-surround",
  "tpope/vim-repeat",
  "tpope/vim-projectionist",
  "sainnhe/gruvbox-material", -- color scheme
  "tpope/vim-unimpaired",

  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "saadparwaiz1/cmp_luasnip",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-nvim-lsp-document-symbol",
  "ThePrimeagen/harpoon",

  -- LSP
  "neovim/nvim-lspconfig", -- enable LSP
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
  "jose-elias-alvarez/typescript.nvim",
  {
    --"~/Documents/github/personal/neotest-dart"
    "sidlatau/neotest-dart",
  },
  "nvim-telescope/telescope.nvim",

  "nvim-treesitter/nvim-treesitter-textobjects",

  -- Git

  {
    "folke/trouble.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {}
    end,
  },

  "nvim-telescope/telescope-dap.nvim",
  "vim-scripts/BufOnly.vim",
  {
    "bkad/camelcasemotion",
    config = function()
      vim.g["camelcasemotion_key"] = "\\"
    end,
  },
  "milch/vim-fastlane",
  "delphinus/vim-firestore",
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  "tpope/vim-abolish",
  "mtdl9/vim-log-highlighting",
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  "whiteinge/diffconflicts",
  { "stevearc/dressing.nvim" },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup {
        max_lines = 1, -- How many lines the window should span. Values <= 0 mean no limit.
      }
    end,
  },
  "wsdjeg/vim-fetch",
  "nvim-treesitter/playground",
  "folke/neodev.nvim",
  {
    "petertriho/nvim-scrollbar",
    config = function()
      require "user.scrollbar"
    end,
  },
  "smartpde/telescope-recent-files",
  "mbbill/undotree",
  {
    "monaqa/dial.nvim",
    config = function()
      local augend = require "dial.augend"
      require("dial.config").augends:register_group {
        -- default augends used when no group name is specified
        default = {
          augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
          augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
          augend.constant.alias.bool, -- boolean value (true <-> false)
        },
      }
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  "RRethy/vim-illuminate",
  "nvim-neotest/neotest-plenary",
  "inkarkat/vim-ReplaceWithRegister",
  {
    "sidlatau/dart-lsp-refactorings.nvim",
    -- "~/Documents/github/personal/dart-lsp-refactorings.nvim",
  },
  {
    "lukas-reineke/lsp-format.nvim",
    config = function()
      require("lsp-format").setup {}
    end,
  },
  {
    "andrewferrier/debugprint.nvim",
    config = function()
      require("debugprint").setup {
        print_tag = "D-->",
      }
    end,
  },
  {
    "akinsho/pubspec-assist.nvim",
    dependencies = "plenary.nvim",
    config = function()
      require("pubspec-assist").setup {}
    end,
  },
}
