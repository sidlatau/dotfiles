local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  ["/"] = {
    '<cmd>lua require("Comment.api").toggle_current_linewise()<CR>',
    "Comment",
  },
  ["a"] = {
    "<cmd>lua require('lsp-fastaction').code_action()<CR>",
    "Code action",
  },
  ["b"] = {
    "<cmd>lua require('user.telescope').sorted_buffer()<cr>",
    "Buffers",
  },
  ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  ["w"] = { "<cmd>w!<CR>", "Save" },
  ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
  ["C"] = { "<cmd>Bufonly<CR>", "Leave single Buffer" },
  ["<leader>"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
  ["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
  ["P"] = { "<cmd>Telescope projects<cr>", "Projects" },
  ["1"] = { ':lua require("harpoon.ui").nav_file(1)<CR>', "Nav 1" },
  ["2"] = { ':lua require("harpoon.ui").nav_file(2)<CR>', "Nav 2" },
  ["3"] = { ':lua require("harpoon.ui").nav_file(3)<CR>', "Nav 3" },
  ["4"] = { ':lua require("harpoon.ui").nav_file(4)<CR>', "Nav 4" },

  h = {
    name = "Harpoon",
    a = { ':lua require("harpoon.mark").add_file()<CR>', "Add" },
    h = { ':lua require("harpoon.ui").toggle_quick_menu()<CR>', "Edit" },
  },

  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },

  f = {
    name = "Flutter",
    f = { "<cmd>Telescope flutter commands<CR>", "Commands list" },
    l = {
      "<cmd>lua require 'user.flutter-tools'.toggle_log()<CR>",
      "Toggle log",
    },
    e = { "<cmd>FlutterEmulators<CR>", "Emulators" },
    r = { "<cmd>FlutterRestart<CR>", "Restart" },
    d = {
      "<cmd>FlutterRun --dart-define=flavor=dev --flavor dev<CR>",
      "Start dev",
    },
    p = {
      "<cmd>FlutterRun --dart-define=flavor=prod --flavor prod<CR>",
      "Start prod",
    },
  },

  g = {
    name = "Git",
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff",
    },
  },

  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = {
      "<cmd>Telescope lsp_document_diagnostics<cr>",
      "Document Diagnostics",
    },
    w = {
      "<cmd>Telescope diagnostics<cr>",
      "Workspace Diagnostics",
    },
    f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    j = {
      "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
      "Prev Diagnostic",
    },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    q = { "<cmd>Trouble workspace_diagnostics<cr>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
  },
  s = {
    name = "Search",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
    s = {
      ":lua require('telescope.builtin').grep_string(require('telescope.themes').get_dropdown({layout_config = {width = 0.8}}))<CR>",
      "Word under cursor",
    },
  },

  t = {
    name = "Test / Terminal",
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },

    t = { "<cmd>Ultest<cr>", "Test file" },
    s = { "<cmd>UltestSummary<cr>", "Summary" },
    d = { "<cmd>UltestDebugNearest<cr>", "Debug nearest" },
    o = { "<cmd>UltestOutput<cr>", "Output" },
    n = { "<cmd>UltestNearest<cr>", "Test nearest" },
    l = { "<cmd>UltestLast<cr>", "Test last" },
    c = { "<cmd>UltestClear<cr>", "Clear test ouput" },
  },
  d = {
    name = "Debug",
    t = {
      "<cmd>lua require'dap'.toggle_breakpoint()<cr>",
      "Toggle Breakpoint",
    },
    C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
    p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
    s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
    q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
    d = { "<cmd>lua require('dapui').toggle()<CR>", "UI" },
    e = { "<cmd>lua require('dapui').eval()<CR>", "Eval" },
    v = {
      "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>",
      "Variables",
    },
    f = {
      "<cmd>lua require'telescope'.extensions.dap.frames{}<CR>",
      "Frames",
    },
  },
  r = {
    name = "Redux",
    s = { "<cmd>Estate<cr>", "state" },
    r = { "<cmd>Ereducer<cr>", "reducer" },
    a = { "<cmd>Eactions<cr>", "actions" },
    m = { "<cmd>Emiddleware<cr>", "middleware" },
  },
}

local vopts = {
  mode = "v", -- VISUAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}
local vmappings = {
  ["/"] = {
    '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>',
    "Comment",
  },
  ["a"] = {
    "<esc><cmd>lua require('lsp-fastaction').range_code_action()<CR>",
    "Range code action",
  },
  ["e"] = {
    "<esc><cmd>lua require('dapui').eval()<CR>",
    "Debug eval",
  },
}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
