require("lazy").setup {
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  "kyazdani42/nvim-web-devicons",
  "moll/vim-bbye",
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require "user.lualine"
    end,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require "user.comment"
    end,
  },
  "JoosepAlviste/nvim-ts-context-commentstring",
  "tpope/vim-surround",
  "tpope/vim-repeat",
  "tpope/vim-projectionist",
  {
    "windwp/nvim-autopairs",
    config = function()
      require "user.autopairs"
    end,
  },

  "sainnhe/gruvbox-material", -- color scheme
  "tpope/vim-unimpaired",

  -- cmp plugins
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require "user.cmp"
    end,
  },
  "hrsh7th/cmp-buffer", -- buffer completions
  "hrsh7th/cmp-path", -- path completions
  "hrsh7th/cmp-cmdline", -- cmdline completions
  {
    "saadparwaiz1/cmp_luasnip",
    config = function()
      require "user.luasnip"
    end,
  },
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-nvim-lsp-document-symbol",
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      local signature_config = {
        hint_enable = false,
        toggle_key = "<C-x>",
      }
      require("lsp_signature").setup(signature_config)
    end,
  },

  {
    "akinsho/toggleterm.nvim",
    config = function()
      require "user.toggleterm"
    end,
  },
  {
    "folke/which-key.nvim",
    config = function()
      require "user.whichkey"
    end,
  },
  "ThePrimeagen/harpoon",

  -- snippets
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
  },

  -- LSP
  "neovim/nvim-lspconfig", -- enable LSP
  { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
  {
    "sidlatau/lsp-fastaction.nvim",
    config = function()
      require "user.lsp-fastaction"
    end,
  },
  "jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
  {
    "jose-elias-alvarez/typescript.nvim",
  },

  {
    "akinsho/flutter-tools.nvim",
    -- dir = "~/Documents/github/personal/flutter-tools.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require "user.flutter-tools"
    end,
    cond = function()
      return not vim.g.vscode
    end,
  },
  {
    --"~/Documents/github/personal/neotest-dart"
    "sidlatau/neotest-dart",
  },
  "nvim-telescope/telescope.nvim",

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require "user.treesitter"
    end,
  },
  "nvim-treesitter/nvim-treesitter-textobjects",

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require "user.gitsigns"
    end,
  },

  {
    "folke/trouble.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {}
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require "user.test"
    end,
  },

  {
    "mfussenegger/nvim-dap",
    config = function()
      require "user.dap"
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
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "main",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require "user.neo-tree"
    end,
  },
  "mtdl9/vim-log-highlighting",
  {
    "j-hui/fidget.nvim",
    config = function()
      require "user.fidget"
    end,
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      require "user.notify"
    end,
  },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  "whiteinge/diffconflicts",
  {
    "lukas-reineke/indent-blankline.nvim",
    config = require "user.indentline"(),
  },
  { "stevearc/dressing.nvim" },
  {
    "ethanholz/nvim-lastplace",
    event = "BufRead",
    config = function()
      require("nvim-lastplace").setup {
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = {
          "gitcommit",
          "gitrebase",
          "svn",
          "hgcommit",
        },
        lastplace_open_folds = true,
      }
    end,
  },
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
  { "smartpde/telescope-recent-files" },
  {
    "sindrets/diffview.nvim",
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
  },
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
  { "RRethy/vim-illuminate" },
  { "nvim-neotest/neotest-plenary" },
  { "inkarkat/vim-ReplaceWithRegister" },
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
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup {
        log_level = "error",
        auto_session_suppress_dirs = {
          "~/",
          "~/Documents/github",
          "~/Downloads",
          "/",
        },
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
