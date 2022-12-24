local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}
-- Install your plugins here
return packer.startup {
  function(use)
    -- My plugins here
    use "wbthomason/packer.nvim" -- Have packer manage itself
    use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
    use "kyazdani42/nvim-web-devicons"
    use "moll/vim-bbye"
    use { "nvim-lualine/lualine.nvim", config = "require 'user.lualine'" }
    use { "numToStr/Comment.nvim", config = "require'user.comment'" }
    use "JoosepAlviste/nvim-ts-context-commentstring"
    use "tpope/vim-surround"
    use "tpope/vim-repeat"
    use "tpope/vim-projectionist"
    use { "windwp/nvim-autopairs", config = "require'user.autopairs'" }

    use "sainnhe/gruvbox-material" -- color scheme
    use "tpope/vim-unimpaired"

    -- cmp plugins
    use { "hrsh7th/nvim-cmp", config = "require'user.cmp'" }
    use "hrsh7th/cmp-buffer" -- buffer completions
    use "hrsh7th/cmp-path" -- path completions
    use "hrsh7th/cmp-cmdline" -- cmdline completions
    use { "saadparwaiz1/cmp_luasnip", config = "require'user.luasnip'" }
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lua"
    use "hrsh7th/cmp-nvim-lsp-document-symbol"

    use { "akinsho/toggleterm.nvim", config = "require'user.toggleterm'" }
    use { "folke/which-key.nvim", config = "require'user.whichkey'" }
    use "ThePrimeagen/harpoon"

    -- snippets
    use { "L3MON4D3/LuaSnip", run = "make install_jsregexp" }

    -- LSP
    use "neovim/nvim-lspconfig" -- enable LSP
    use { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" }
    use {
      "sidlatau/lsp-fastaction.nvim",
      config = "require'user.lsp-fastaction'",
    }
    use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
    use {
      "jose-elias-alvarez/typescript.nvim",
      config = "require'user.typescript'",
    }

    use {
      "akinsho/flutter-tools.nvim",
      -- "~/Documents/github/personal/flutter-tools.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = "require'user.flutter-tools'",
      cond = function()
        return not vim.g.vscode
      end,
    }
    use {
      --"~/Documents/github/personal/neotest-dart"
      "sidlatau/neotest-dart",
    }
    use "nvim-telescope/telescope.nvim"

    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = "require'user.treesitter'",
    }
    use "nvim-treesitter/nvim-treesitter-textobjects"

    -- Git
    use { "lewis6991/gitsigns.nvim", config = "require'user.gitsigns'" }

    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup {}
      end,
    }
    use {
      "nvim-neotest/neotest",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
      },
      config = "require'user.test'",
    }

    use { "mfussenegger/nvim-dap", config = "require'user.dap'" }
    use {
      "rcarriga/nvim-dap-ui",
      config = function()
        require("dapui").setup()
      end,
    }
    use "nvim-telescope/telescope-dap.nvim"
    use "vim-scripts/BufOnly.vim"
    use {
      "bkad/camelcasemotion",
      config = function()
        vim.g["camelcasemotion_key"] = "\\"
      end,
    }
    use "milch/vim-fastlane"
    use "delphinus/vim-firestore"
    use "tpope/vim-obsession"
    use "tpope/vim-fugitive"
    use "tpope/vim-rhubarb"
    use "tpope/vim-abolish"
    use {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "main",
      requires = {
        "nvim-lua/plenary.nvim",
        "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
      },
      config = "require 'user.neo-tree'",
    }
    use "mtdl9/vim-log-highlighting"
    use { "j-hui/fidget.nvim", config = "require'user.fidget'" }
    use { "rcarriga/nvim-notify", config = "require 'user.notify'" }
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
    use "whiteinge/diffconflicts"
    use {
      "lukas-reineke/indent-blankline.nvim",
      config = require "user.indentline"(),
    }
    use { "stevearc/dressing.nvim" }
    use {
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
    }
    use {
      "nvim-treesitter/nvim-treesitter-context",
      config = function()
        require("treesitter-context").setup {
          max_lines = 1, -- How many lines the window should span. Values <= 0 mean no limit.
        }
      end,
    }
    use "wsdjeg/vim-fetch"
    use "nvim-treesitter/playground"
    use "folke/neodev.nvim"
    use {
      "petertriho/nvim-scrollbar",
      config = "require 'user.scrollbar'",
    }
    use { "smartpde/telescope-recent-files" }
    use {
      "sindrets/diffview.nvim",
      requires = "nvim-lua/plenary.nvim",
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
    use "mbbill/undotree"
    use {
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
    }
    use {
      "iamcco/markdown-preview.nvim",
      run = "cd app && npm install",
      setup = function()
        vim.g.mkdp_filetypes = { "markdown" }
      end,
      ft = { "markdown" },
    }
    use { "RRethy/vim-illuminate" }
    use { "psliwka/vim-dirtytalk", run = ":DirtytalkUpdate" }
    use { "nvim-neotest/neotest-plenary" }
    use { "inkarkat/vim-ReplaceWithRegister" }
    use {
      "ray-x/go.nvim",
      requires = "ray-x/guihua.lua",
      config = "require 'user.go'",
    }
    use {
      "sidlatau/dart-lsp-refactorings.nvim",
      -- "~/Documents/github/personal/dart-lsp-refactorings.nvim",
    }
    use {
      "lukas-reineke/lsp-format.nvim",
      config = function()
        require("lsp-format").setup {}
      end,
    }
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
      require("packer").sync()
    end
  end,
  config = {
    max_jobs = 10,
  },
}
