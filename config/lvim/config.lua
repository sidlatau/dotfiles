lvim.colorscheme = 'gruvbox-material'

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<C-p>"] = ":Telescope find_files<cr>"
vim.api.nvim_set_keymap('v', '<Leader>a', "<esc><cmd>lua require('lsp-fastaction').range_code_action()<CR>", { noremap = true, silent = true })


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

lsp_status.config {
    indicator_info = '',
    indicator_errors = '',
    indicator_hint= '',
    status_symbol= '',
}

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
    "vim-test/vim-test",
    config = function ()
      vim.g["test#dart#fluttertest#executable"] = "fvm flutter test"
      vim.g["test#strategy"]= "dispatch"
    end
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
      vim.g["EasyClipUsePasteToggleDefaults"] = false
      vim.g["EasyClipUsePasteDefaults"] = false
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
          capabilities = require('lsp-status').capabilities
        },
        debugger = { -- integrate with nvim dap + install dart code debugger
          enabled = true,
        },
        fvm = true,
        widget_guides = {
          enabled = true,
        },
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
  { "tpope/vim-repeat" },
  {
    "windwp/lsp-fastaction.nvim",
    config = function ()
      require('lsp-fastaction').setup({
          hide_cursor = true,
          action_data = {
            --- action for filetype dart
              ['dart'] = {
                { pattern = 'padding', key = 'p', order = 2 },
                { pattern = 'wrap with column', key = 'c', order = 3 },
                { pattern = 'wrap with row', key = 'r', order = 3 },
                { pattern = 'remove', key = 'R', order = 5 },
                  --range code action
                  -- { pattern = "surround with %'if'", key = 'i', order = 2 },
                  -- { pattern = 'try%-catch', key = 't', order = 2 },
                  -- { pattern = 'for%-in', key = 'f', order = 2 },
                  -- { pattern = 'setstate', key = 's', order = 2 },
              },
          },
      })
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    config = function()
    end
  },
  { "radenling/vim-dispatch-neovim" },
  {
    "rcarriga/nvim-dap-ui",
    requires = {"mfussenegger/nvim-dap"},
    config = function ()
     require("dapui").setup()
    end
  },
  { 
    "mhinz/vim-sayonara",
    config = function ()
       vim.g["sayonara_confirm_quit"] = true
    end
  }
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

lvim.builtin.lualine.sections = {
  lualine_z = {"require'lsp-status'.status()"},
}

-- vim-test
vim.opt.timeoutlen = 1000


lvim.builtin.which_key.mappings["t"] = {
  name = "Diagnostics/Tests",
  t = { "<cmd>TroubleToggle<cr>", "trouble" },
  w = { "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>", "workspace" },
  d = { "<cmd>TroubleToggle lsp_document_diagnostics<cr>", "document" },
  q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
  r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
  n = { "<cmd>TestNearest<cr>", "Test nearest" },
  f = { "<cmd>TestFile<cr>", "Test file" },
  l = { "<cmd>TestLast<cr>", "Test last" },
}

lvim. builtin.which_key.mappings["a"] = {"<cmd>lua require('lsp-fastaction').code_action()<CR>",  "Code action"}
lvim. builtin.which_key.mappings["q"] = {"<cmd>Sayonara<CR>",  "Close"}
lvim. builtin.which_key.mappings["<space>"] = {":set hlsearch!<CR>",  "Clear search"}

require("luasnip/loaders/from_vscode").load({ paths = {"~/Documents/personal/vim/snippets"} })
require'luasnip'.filetype_extend("dart", {"flutter"})

require'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
}
