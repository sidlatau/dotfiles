--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "onedarker"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = ""
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = false
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "css",
  "rust",
  "java",
  "yaml"
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings
-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end
-- you can overwrite the null_ls setup table (useful for setting the root_dir function)
-- lvim.lsp.null_ls.setup = {
--   root_dir = require("lspconfig").util.root_pattern("Makefile", ".git", "node_modules"),
-- }
-- or if you need something more advanced
-- lvim.lsp.null_ls.setup.root_dir = function(fname)
--   if vim.bo.filetype == "javascript" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "node_modules")(fname)
--       or require("lspconfig/util").path.dirname(fname)
--   elseif vim.bo.filetype == "php" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "composer.json")(fname) or vim.fn.getcwd()
--   else
--     return require("lspconfig/util").root_pattern("Makefile", ".git")(fname) or require("lspconfig/util").path.dirname(fname)
--   end
-- end

-- set a formatter if you want to override the default lsp one (if it exists)
-- lvim.lang.python.formatters = {
--   {
--     exe = "black",
--   }
-- }
-- set an additional linter
-- lvim.lang.python.linters = {
--   {
--     exe = "flake8",
--   }
-- }

-- Additional Plugins
-- lvim.plugins = {
--     {"folke/tokyonight.nvim"},
--     {
--       "folke/trouble.nvim",
--       cmd = "TroubleToggle",
--     },
-- }

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }

local lsp_status = require("lsp-status")
lsp_status.register_progress()

lvim.lsp.override = { "dart" }
lvim.builtin.dap.active = true

lvim.plugins = {
  {
    "tpope/vim-surround",
  },
  {
    "bkad/camelcasemotion"
  },
  {
    "tpope/vim-unimpaired"
  },
  {
    "tpope/vim-obsession"
  },
  {
    "ThePrimeagen/harpoon",
    requires = "nvim-lua/plenary.nvim",
  },
  {
    "mhinz/vim-startify"
  },
  {
    "nvim-lua/lsp-status.nvim"
  },
  {
    "tpope/vim-projectionist"
  },
  {
    "vim-test/vim-test"
  },
  {
    "tpope/vim-dispatch"
  },
  {
    "akinsho/flutter-tools.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("flutter-tools").setup {
        lsp = {
          on_attach = function(client, bufnr)
            lsp_status.on_attach(client)
            require("lvim.lsp").common_on_attach(client, bufnr)
          end,
          capabilities = require('lsp-status').capabilities
        },
        debugger = { -- integrate with nvim dap + install dart code debugger
          enabled = true,
        },
        fvm = true,
      }
      require("telescope").load_extension("flutter")
    end,
  },
}

lvim.builtin.which_key.mappings["F"] = {
  name = "+Flutter",
  f = {"<cmd>Telescope flutter commands<CR>", "Commands list"},
  e = {"<cmd>FlutterEmulators<CR>", "Emulators"},
  r = {"<cmd>FlutterRestart<CR>", "Restart"},
}

-- Harpoon
lvim.builtin.which_key.mappings["h"] = {
  name = "+Harpoon",
  a = { ":lua require(\"harpoon.mark\").add_file()<CR>", "Add" },
  h = { ":lua require(\"harpoon.ui\").toggle_quick_menu()<CR>", "Edit" },
  q = { ":lua require(\"harpoon.ui\").nav_file(1)<CR>", "Nav 1" },
  w = { ":lua require(\"harpoon.ui\").nav_file(2)<CR>", "Nav 2" },
  e = { ":lua require(\"harpoon.ui\").nav_file(3)<CR>", "Nav 3" },
  r = { ":lua require(\"harpoon.ui\").nav_file(4)<CR>", "Nav 4" },
}

lvim.builtin.which_key.on_config_done = function (wk)
   -- Harpoon quickmenu is closed when which key popup is opened
   -- So disabling which_key for d and y keys
   local ignore_key =  "which_key_ignore"
   wk.register(ignore_key, { mode="n", prefix="d" })
   wk.register(ignore_key, { mode="n", prefix="y" })
end


lvim.builtin.lualine.sections = {lualine_z = {"require'lsp-status'.status()"}}

-- vim-test
vim.g["test#dart#fluttertest#executable"] = "fvm flutter test"
vim.g["test#strategy"]= "neovim"
vim.opt.timeoutlen = 3000
vim.opt.autoread = true
