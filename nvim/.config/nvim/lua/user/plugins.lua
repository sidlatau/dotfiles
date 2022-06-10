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
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "kyazdani42/nvim-web-devicons"
  use "moll/vim-bbye"
  use { "nvim-lualine/lualine.nvim", config = "require 'user.lualine'" }
  use { "numToStr/Comment.nvim", config = "require'user.comment'" }
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use "machakann/vim-highlightedyank"
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
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
  use { "folke/which-key.nvim", config = "require'user.whichkey'" }
  use "ThePrimeagen/harpoon"

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use {
    "~/Documents/github/personal/lsp-fastaction.nvim",
    config = "require'user.lsp-fastaction'",
  }
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use "jose-elias-alvarez/nvim-lsp-ts-utils"

  use {
    "akinsho/flutter-tools.nvim",
    -- "~/Documents/github/personal/flutter-tools.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = "require'user.flutter-tools'",
    cond = function()
      return not vim.g.vscode
    end,
  }
  use "nvim-lua/lsp-status.nvim"

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
  use { "vim-test/vim-test" }
  use {
    "rcarriga/vim-ultest",
    run = ":UpdateRemotePlugins",
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
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = "require 'user.neo-tree'",
  }
  use { "abecodes/tabout.nvim", config = "require'user.tabout'" }
  -- use { "github/copilot.vim", config = "require'user.copilot'" }
  use {
    "zbirenbaum/copilot.lua",
    event = { "VimEnter" },
    config = function()
      vim.defer_fn(function()
        require("copilot").setup()
      end, 100)
    end,
  }
  use {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua", "nvim-cmp" },
  }
  use "dart-lang/dart-vim-plugin"
  use "mtdl9/vim-log-highlighting"
  use { "j-hui/fidget.nvim", config = "require'user.fidget'" }
  use { "rcarriga/nvim-notify", config = "require 'user.notify'" }
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
  use {
    "akinsho/git-conflict.nvim",
    config = function()
      require("git-conflict").setup {
        default_mappings = true, -- disable buffer local mapping created by this plugin
        disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
        highlights = { -- They must have background color, otherwise the default color will be used
          incoming = "DiffText",
          current = "DiffAdd",
        },
      }
    end,
  }
  use "whiteinge/diffconflicts"
  use "rickhowe/diffchar.vim"
  use {
    "lukas-reineke/indent-blankline.nvim",
    config = require "user.indentline"(),
  }
  use {
    "lukas-reineke/lsp-format.nvim",
    config = function()
      require("lsp-format").setup {}
    end,
  }
  use { "stevearc/dressing.nvim" }
  use {
    "lukas-reineke/virt-column.nvim",
    config = function()
      require("virt-column").setup()
    end,
  }
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
end)
