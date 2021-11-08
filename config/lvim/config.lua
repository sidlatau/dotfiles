lvim.colorscheme = 'gruvbox-material'

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<C-p>"] = ":Telescope find_files<cr>"

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = false
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = "maintained"

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

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
    "sainnhe/gruvbox-material"
  },
  {
    "svermeulen/vim-easyclip",
    config = function ()
      vim.g["EasyClipUseSubstituteDefaults"] = true
    end
  },
  {
    "akinsho/flutter-tools.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("flutter-tools").setup {
        lsp = {
          on_attach = function(client, bufnr)
            --lsp_status.on_attach(client)
            require("lvim.lsp").common_on_attach(client, bufnr)
          end,
          --capabilities = require('lsp-status').capabilities
        },
        debugger = { -- integrate with nvim dap + install dart code debugger
          enabled = true,
        },
        fvm = true,
      }
      require("telescope").load_extension("flutter")
    end,
  },
  {
    "f-person/git-blame.nvim",
    event = "BufRead",
    config = function()
      vim.cmd "highlight default link gitblame SpecialComment"
      vim.g.gitblame_enabled = 0
      vim.g.gitblame_date_format="%r"
      vim.g.gitblame_highlight_group="Question"
    end,
  },
  {
    "folke/trouble.nvim",
      cmd = "TroubleToggle",
  },
  {
    "Pocco81/AutoSave.nvim",
    config = function()
      require("autosave").setup()
    end,
  },
  { "tpope/vim-repeat" },
}

lvim.builtin.which_key.mappings["f"] = {
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
vim.g["test#strategy"]= "dispatch"
vim.opt.timeoutlen = 1000


lvim.builtin.which_key.mappings["t"] = {
  name = "Diagnostics",
  t = { "<cmd>TroubleToggle<cr>", "trouble" },
  w = { "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>", "workspace" },
  d = { "<cmd>TroubleToggle lsp_document_diagnostics<cr>", "document" },
  q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
  l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
  r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
}
