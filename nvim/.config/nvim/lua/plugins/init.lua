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

  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "jose-elias-alvarez/null-ls.nvim",
  {
    "jose-elias-alvarez/typescript.nvim",
    config = function()
      require("typescript").setup {
        server = { -- pass options to lspconfig's setup method
          on_attach = require("config.lsp.handlers").on_attach,
          capabilities = require("config.lsp.handlers").capabilities,
        },
      }
    end,
  },
  {
    "sidlatau/neotest-dart",
    dev = false,
  },

  "nvim-treesitter/nvim-treesitter-textobjects",
  "nvim-telescope/telescope-dap.nvim",
  "vim-scripts/BufOnly.vim",
  "milch/vim-fastlane",
  "delphinus/vim-firestore",
  {
    "tpope/vim-fugitive",
    dependencies = {
      "cedarbaum/fugitive-azure-devops.vim",
    },
  },

  "tpope/vim-rhubarb",
  "tpope/vim-abolish",
  "mtdl9/vim-log-highlighting",
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  "whiteinge/diffconflicts",
  "wsdjeg/vim-fetch",
  { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
  "folke/neodev.nvim",
  "smartpde/telescope-recent-files",
  "mbbill/undotree",
  "RRethy/vim-illuminate",
  "nvim-neotest/neotest-plenary",
  "inkarkat/vim-ReplaceWithRegister",
  {
    "sidlatau/dart-lsp-refactorings.nvim",
    dev = false,
  },
}
