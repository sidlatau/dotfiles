local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = false, -- shows a list of your marks on ' and `
    registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
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
    function()
      require("Comment.api").toggle.linewise.current()
    end,
    "Comment",
  },
  ["a"] = {
    require("lsp-fastaction").code_action,
    "Code action",
  },
  ["b"] = {
    require("user.telescope_config").sorted_buffers,
    "Buffers",
  },
  ["o"] = {
    require("telescope").extensions.recent_files.pick,
    "Recent files",
  },
  ["e"] = { "<cmd>Neotree float toggle reveal<cr>", "Explorer" },
  ["u"] = { "<cmd>UndotreeToggle<cr>", "Undotree" },
  ["w"] = {
    "<cmd>wa<cr>",
    "Save",
  },
  ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
  ["C"] = { "<cmd>Bufonly<CR>", "Leave single Buffer" },
  ["<leader>"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
  ["F"] = {
    function()
      require("user.telescope_config").live_grep()
    end,
    "Find Text",
  },
  ["1"] = { ':lua require("harpoon.ui").nav_file(1)<CR>', "Nav 1" },
  ["2"] = { ':lua require("harpoon.ui").nav_file(2)<CR>', "Nav 2" },
  ["3"] = { ':lua require("harpoon.ui").nav_file(3)<CR>', "Nav 3" },
  ["4"] = { ':lua require("harpoon.ui").nav_file(4)<CR>', "Nav 4" },

  h = {
    name = "Harpoon",
    a = {
      function()
        require("harpoon.mark").add_file()
      end,
      "Add",
    },
    h = {
      function()
        require("harpoon.ui").toggle_quick_menu()
      end,
      "Edit",
    },
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
    c = { "<cmd>Telescope flutter commands<CR>", "Commands list" },
    l = {
      function()
        require("user.flutter-tools").toggle_log()
      end,
      "Toggle log",
    },
    e = { "<cmd>FlutterEmulators<CR>", "Emulators" },
    r = { "<cmd>FlutterRestart<CR>", "Restart" },
    b = {
      "<cmd>TermExec cmd='fvm flutter pub run build_runner build --delete-conflicting-outputs'<CR>",
      "Run code generation",
    },
    w = {
      "<cmd>TermExec cmd='fvm flutter pub run build_runner watch'<CR>",
      "Watch code generation",
    },
    s = {
      require("user.toggleterm").regenerate_single_directory,
      "Reneration single directory",
    },
    g = {
      "<cmd>FlutterPubGet<CR>",
      "Flutter pub get",
    },
    q = {
      "<cmd>FlutterQuit<CR>",
      "Flutter quit",
    },
    f = {
      "<cmd>FlutterRun<CR>",
      "Flutter run",
    },
    z = {
      "<cmd>FlutterLogClear<CR>",
      "Flutter log clear",
    },
    v = {
      "<cmd>FlutterVisualDebug<CR>",
      "Flutter visual debug",
    },
    d = {
      "<cmd>FlutterDevices<CR>",
      "Flutter devices",
    },
    o = {
      "<cmd>FlutterOutlineToggle<CR>",
      "Flutter outline",
    },
  },

  g = {
    name = "Git",
    f = { "<cmd>!fork<cr><cr>", "Open Fork app" },
    h = { "<cmd>DiffviewFileHistory %<cr>", "File history" },
    g = { require("user.toggleterm").lazygit_toggle, "Lazygit" },
    j = {
      function()
        require("gitsigns").next_hunk()
      end,
      "Next Hunk",
    },
    k = {
      function()
        require("gitsigns").prev_hunk()
      end,
      "Prev Hunk",
    },
    l = {
      function()
        require("gitsigns").blame_line()
      end,
      "Blame",
    },
    p = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "Preview Hunk",
    },
    r = {
      function()
        require("gitsigns").reset_hunk()
      end,
      "Reset Hunk",
    },
    R = {
      function()
        require("gitsigns").reset_buffer()
      end,
      "Reset Buffer",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    t = { "<cmd>0Gclog<cr>", "File timeline" },
    d = {
      "<cmd>DiffviewOpen<cr>",
      "Diff",
    },
    s = { "<cmd>.GBrowse<cr>", "Show in GitHub" },
    z = {
      function()
        require("gitsigns").toggle_deleted()
      end,
      "Toggle deleted",
    },
  },

  l = {
    name = "LSP",
    a = { vim.lsp.buf.code_action, "Code Action" },
    d = {
      "<cmd>Telescope lsp_document_diagnostics<cr>",
      "Document Diagnostics",
    },
    w = {
      "<cmd>Telescope diagnostics<cr>",
      "Workspace Diagnostics",
    },
    f = { vim.lsp.buf.formatting, "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    j = {
      vim.diagnostic.goto_next,
      "Next Diagnostic",
    },
    k = {
      vim.diagnostic.goto_prev,
      "Prev Diagnostic",
    },
    l = { vim.lsp.codelens.run, "CodeLens Action" },
    q = { "<cmd>Trouble workspace_diagnostics<cr>", "Quickfix" },
    r = {
      function()
        require("dart-lsp-refactorings").rename()
        -- vim.lsp.buf.rename()
      end,
      "Rename",
    },
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
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
    s = {
      ":lua require('telescope.builtin').grep_string(require('telescope.themes').get_dropdown({layout_config = {width = 0.8}}))<CR>",
      "Word under cursor",
    },
  },
  n = {
    name = "Navigate",
    s = { "<cmd>Estate<cr>", "state" },
    r = { "<cmd>Ereducer<cr>", "reducer" },
    a = { "<cmd>Eactions<cr>", "actions" },
    m = { "<cmd>Emiddleware<cr>", "middleware" },
  },
  R = {
    "<cmd>Telescope resume<cr>",
    "Telescope resume",
  },

  t = {
    name = "Test / Terminal",
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },

    t = {
      function()
        ---@diagnostic disable-next-line: missing-parameter
        require("neotest").run.run(vim.fn.expand "%")
      end,
      "Test file",
    },
    s = {
      function()
        require("neotest").summary.toggle()
      end,
      "Summary",
    },
    o = {
      function()
        require("neotest").output.open { enter = true }
      end,
      "Output",
    },
    n = {
      function()
        require("neotest").run.run()
      end,
      "Test nearest",
    },
    l = {
      function()
        require("neotest").run.run_last()
      end,
      "Test last",
    },
    d = {
      function()
        require("neotest").run.run { strategy = "dap" }
      end,
      "Debug nearest",
    },
  },
  d = {
    name = "Debug",
    t = {
      function()
        require("dap").toggle_breakpoint()
      end,
      "Toggle Breakpoint",
    },
    C = {
      function()
        require("dap").run_to_cursor()
      end,
      "Run To Cursor",
    },
    r = {
      function()
        require("dap").repl.toggle()
      end,
      "Toggle Repl",
    },
    s = {
      function()
        require("dap").continue()
      end,
      "Start",
    },
    q = {
      function()
        require("dap").close()
      end,
      "Quit",
    },
    d = {
      function()
        require("dapui").toggle()
      end,
      "UI",
    },
    e = {
      function()
        ---@diagnostic disable-next-line: missing-parameter
        require("dapui").eval()
      end,
      "Eval",
    },
    v = {
      function()
        local widgets = require "dap.ui.widgets"
        widgets.centered_float(widgets.scopes)
      end,
      "Variables",
    },
    f = {
      function()
        require("telescope").extensions.dap.frames()
      end,
      "Frames",
    },
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
    '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>',
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
