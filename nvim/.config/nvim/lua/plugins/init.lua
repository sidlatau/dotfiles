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
    dir = "~/Documents/github/personal/neotest-dart",
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
    },
  },
  { "b0o/schemastore.nvim" },
  { "rose-pine/neovim", name = "rose-pine" },
  {
    "3rd/image.nvim",
    cond = vim.env.KITTY_SCROLLBACK_NVIM ~= "true",
    opts = {
      integrations = {
        markdown = {
          resolve_image_path = function(document_path, image_path, fallback)
            vim.print(document_path)
            vim.print(image_path)
            local working_dir = vim.fn.getcwd()
            -- Format image path for Obsidian notes
            if working_dir:find "github/personal/notes" then
              vim.print "Found notes directory"
              return working_dir .. "/attachments/" .. image_path
            end
            return fallback(document_path, image_path)
          end,
        },
      },
    },
  },
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
}
