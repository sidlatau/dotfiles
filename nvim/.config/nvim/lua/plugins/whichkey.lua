return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    icons = { rules = false },
    delay = function(ctx)
      return 1500
    end,
    triggers = {
      { "<leader>", mode = { "n", "v" } },
    },
    plugins = {
      marks = false, -- shows a list of your marks on ' and `
      registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      -- No actual key bindings are created
      spelling = {
        enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
        suggestions = 20, -- how many suggestions should be shown in the list?
      },
      presets = {
        operators = false, -- adds help for operators like d, y, ...
        motions = false, -- adds help for motions
        text_objects = false, -- help for text objects triggered after entering an operator
        windows = false, -- default bindings on <c-w>
        nav = false, -- misc bindings to work with windows
        z = true, -- bindings for folds, spelling and others prefixed with z
        g = false, -- bindings for prefixed with g
      },
    },
    spec = {
      {
        "<leader>b",
        function()
          require("telescope.builtin").buffers(
            require("telescope.themes").get_dropdown {
              previewer = false,
              sort_mru = true,
              attach_mappings = function(prompt_bufnr, map)
                local delete_buf = function()
                  local selection =
                    require("telescope.actions.state").get_selected_entry()
                  require("telescope.actions").close(prompt_bufnr)
                  vim.api.nvim_buf_delete(selection.bufnr, { force = true })
                end
                map("i", "<c-x>", delete_buf)
                return true
              end,
            }
          )
        end,
        desc = "Buffers",
      },
      {
        "<leader>e",
        "<cmd>Neotree float toggle reveal_force_cwd<cr>",
        desc = "Explorer",
      },
      { "<leader>c", "<cmd>Bdelete!<CR>", desc = "Close Buffer" },
      { "<leader>C", "<cmd>Bufonly<CR>", desc = "Leave single Buffer" },
      { "<esc>", "<cmd>nohlsearch<CR>", desc = "Clear search" },
      {
        "<leader><leader>",
        function()
          if vim.lsp.get_clients()[0] then
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {})
          end
        end,
        desc = "No Highlight",
      },
      {
        "<leader>F",
        function()
          require("telescope.builtin").live_grep(
            require("telescope.themes").get_dropdown()
          )
        end,
        desc = "Find Text",
      },
      {
        "<leader>1",
        ':lua require("harpoon.ui").nav_file(1)<CR>',
        desc = "Nav 1",
      },
      {
        "<leader>2",
        ':lua require("harpoon.ui").nav_file(2)<CR>',
        desc = "Nav 2",
      },
      {
        "<leader>3",
        ':lua require("harpoon.ui").nav_file(3)<CR>',
        desc = "Nav 3",
      },
      {
        "<leader>4",
        ':lua require("harpoon.ui").nav_file(4)<CR>',
        desc = "Nav 4",
      },
      {
        "<leader>h",
        group = "Harpoon",
        {
          "<leader>ha",
          function()
            require("harpoon.mark").add_file()
          end,
          desc = "Add",
        },
        {
          "<leader>hh",
          function()
            require("harpoon.ui").toggle_quick_menu()
          end,
          desc = "Edit",
        },
      },
      {
        "<leader>p",
        group = "ChatGPT",
        { "<leader>pc", "<cmd>ChatGPT<CR>", desc = "ChatGPT" },
        {
          "<leader>pe",
          "<cmd>ChatGPTEditWithInstruction<CR>",
          desc = "Edit with instruction",
          mode = { "n", "v" },
        },
        {
          "<leader>pg",
          "<cmd>ChatGPTRun grammar_correction<CR>",
          desc = "Grammar Correction",
          mode = { "n", "v" },
        },
        {
          "<leader>ptn",
          "<cmd>ChatGPTRun translate nb<CR>",
          desc = "Translate Norwegian",
          mode = { "v" },
        },
        {
          "<leader>pk",
          "<cmd>ChatGPTRun keywords<CR>",
          desc = "Keywords",
          mode = { "n", "v" },
        },
        {
          "<leader>pa",
          "<cmd>ChatGPTRun add_tests<CR>",
          desc = "Add Tests",
          mode = { "n", "v" },
        },
        {
          "<leader>po",
          "<cmd>ChatGPTRun optimize_code<CR>",
          desc = "Optimize Code",
          mode = { "n", "v" },
        },
        {
          "<leader>ps",
          "<cmd>ChatGPTRun summarize<CR>",
          desc = "Summarize",
          mode = { "n", "v" },
        },
        {
          "<leader>pf",
          "<cmd>ChatGPTRun fix_bugs<CR>",
          desc = "Fix Bugs",
          mode = { "n", "v" },
        },
        {
          "<leader>px",
          "<cmd>ChatGPTRun explain_code<CR>",
          desc = "Explain Code",
          mode = { "n", "v" },
        },
        {
          "<leader>pl",
          "<cmd>ChatGPTRun code_readability_analysis<CR>",
          desc = "Code Readability Analysis",
          mode = { "n", "v" },
        },
      },
      {
        "<leader>f",
        group = "Flutter",
        {
          "<leader>fc",
          "<cmd>Telescope flutter commands<CR>",
          desc = "Commands list",
        },
        {
          "<leader>fl",
          function()
            require("config").toggle_flutter_log()
          end,
          desc = "Toggle log",
        },
        {
          "<leader>fe",
          "<cmd>FlutterEmulators<CR>",
          desc = "Emulators",
        },
        {
          "<leader>fr",
          "<cmd>FlutterRestart<CR>",
          desc = "Restart",
        },
        {
          "<leader>fB",
          "<cmd>TermExec cmd='fvm dart run build_runner build --delete-conflicting-outputs'<CR>",
          desc = "Run code generation",
        },
        {
          "<leader>fw",
          "<cmd>TermExec cmd='fvm dart run build_runner watch'<CR>",
          desc = "Watch code generation",
        },
        {
          "<leader>fb",
          function()
            require("config.toggleterm").regenerate_single_directory()
          end,
          desc = "Reneration single directory",
        },
        {
          "<leader>fg",
          "<cmd>FlutterPubGet<CR>",
          desc = "Flutter pub get",
        },
        {
          "<leader>fq",
          "<cmd>FlutterQuit<CR>",
          desc = "Flutter quit",
        },
        {
          "<leader>ff",
          "<cmd>FlutterRun<CR>",
          desc = "Flutter run",
        },
        {
          "<leader>fz",
          "<cmd>FlutterLogClear<CR>",
          desc = "Flutter log clear",
        },
        {
          "<leader>fv",
          "<cmd>FlutterVisualDebug<CR>",
          desc = "Flutter visual debug",
        },
        {
          "<leader>fD",
          "<cmd>FlutterDevices<CR>",
          desc = "Flutter devices",
        },
        {
          "<leader>ftb",
          function()
            require("config.dart_mason").list_bricks()
          end,
          desc = "List bricks",
        },
        {
          "<leader>fd",
          "<cmd>DBUIToggle<cr>",
          desc = "DBUI",
        },
        {
          "<leader>fo",
          function()
            require("config.pick_db").open_simulator_db_connection()
          end,
          desc = "Add simulator DB connection",
        },
        {
          "<leader>fu",
          "<cmd>PubspecAssistPickVersion<cr>",
          desc = "Pubspec assist pick version",
        },
      },
      {
        "<leader>g",
        group = "Git",
        {
          "<leader>gf",
          "<cmd>!fork<cr><cr>",
          desc = "Open Fork app",
        },
        {
          "<leader>gH",
          "<cmd>Telescope advanced_git_search search_log_content_file<cr>",
          desc = "Advanced git search",
        },
        {
          "<leader>go",
          function()
            require("telescope.builtin").git_status(
              require("telescope.themes").get_dropdown {}
            )
          end,
          desc = "Open changed file",
        },
        {
          "<leader>gb",
          "<cmd>Telescope git_branches<cr>",
          desc = "Checkout branch",
        },
        {
          "<leader>gc",
          "<cmd>Telescope advanced_git_search search_log_content<cr>",
          desc = "Git log",
        },
        { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff", group = "Git" },
      },
      {
        "<leader>l",
        group = "LSP",
        {
          "<leader>la",
          function()
            vim.lsp.buf.code_action()
          end,
          desc = "Lsp Code action",
        },
        {
          "<leader>ld",
          "<cmd>Telescope lsp_document_diagnostics<cr>",
          desc = "Document Diagnostics",
        },
        {
          "<leader>lw",
          "<cmd>Telescope diagnostics<cr>",
          desc = "Workspace Diagnostics",
        },
        { "<leader>lf", vim.lsp.buf.formatting, desc = "Format" },
        { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info" },
        {
          "<leader>lI",
          "<cmd>LspInstallInfo<cr>",
          desc = "Installer Info",
        },
        {
          "<leader>ll",
          vim.lsp.codelens.run,
          desc = "CodeLens Action",
        },
        {
          "<leader>lr",
          function()
            require("flutter-tools.lsp.rename").rename()
          end,
          desc = "Rename",
        },
        {
          "<leader>ls",
          "<cmd>Telescope lsp_document_symbols<cr>",
          desc = "Document Symbols",
        },
        {
          "<leader>lS",
          "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
          desc = "Workspace Symbols",
        },
        {
          "<leader>lh",
          function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {})
          end,
          desc = "Inlay hints",
        },
      },
      {
        "<leader>s",
        group = "Search",
        {
          "<leader>sc",
          "<cmd>Telescope neoclip<cr>",
          desc = "Clipboard",
        },
        {
          "<leader>sh",
          "<cmd>Telescope help_tags<cr>",
          desc = "Find Help",
        },
        {
          "<leader>sM",
          "<cmd>Telescope man_pages<cr>",
          desc = "Man Pages",
        },
        {
          "<leader>sR",
          "<cmd>Telescope registers<cr>",
          desc = "Registers",
        },
        {
          "<leader>sk",
          "<cmd>Telescope keymaps<cr>",
          desc = "Keymaps",
        },
        {
          "<leader>sC",
          "<cmd>Telescope commands<cr>",
          desc = "Commands",
        },
        {
          "<leader>ss",
          function()
            require("telescope.builtin").grep_string(
              require("telescope.themes").get_dropdown {
                {
                  layout_config = { width = 0.8 },
                },
              }
            )
          end,
          desc = "Word under cursor",
        },
      },
      {
        "<leader>R",
        "<cmd>Telescope resume<cr>",
        desc = "Telescope resume",
      },
      {
        "<leader>t",
        group = "Test / Terminal",
        {
          "<leader>tf",
          "<cmd>ToggleTerm direction=float<cr>",
          desc = "Float",
        },
        {
          "<leader>tt",
          function()
            ---@diagnostic disable-next-line: missing-parameter
            require("neotest").run.run(vim.fn.expand "%")
          end,
          desc = "Test file",
        },
        {
          "<leader>ts",
          function()
            require("neotest").summary.toggle()
          end,
          desc = "Summary",
        },
        {
          "<leader>to",
          function()
            require("neotest").output.open { enter = true }
          end,
          desc = "Output",
        },
        {
          "<leader>tn",
          function()
            require("neotest").run.run()
          end,
          desc = "Test nearest",
        },
        {
          "<leader>tl",
          function()
            require("neotest").run.run_last()
          end,
          desc = "Test last",
        },
        {
          "<leader>td",
          function()
            require("neotest").run.run { strategy = "dap" }
          end,
          desc = "Debug nearest",
        },
      },
      {
        "<leader>d",
        group = "Debug",
        {
          "<leader>dt",
          function()
            require("dap").toggle_breakpoint()
          end,
          desc = "Toggle Breakpoint",
        },
        {
          "<leader>dr",
          function()
            require("dap").repl.toggle()
          end,
          desc = "Toggle Repl",
        },
        {
          "<leader>dq",
          function()
            require("dap").close()
          end,
          desc = "Quit",
        },
        {
          "<leader>dd",
          function()
            require("dap.ui.widgets").hover()
          end,
          desc = "Hover",
        },
        {
          "<leader>dv",
          function()
            local widgets = require "dap.ui.widgets"
            widgets.centered_float(widgets.scopes)
          end,
          desc = "Variables",
        },
        {
          "<leader>df",
          function()
            require("telescope").extensions.dap.frames()
          end,
          desc = "Frames",
        },
        {
          "<leader>db",
          function()
            require("telescope").extensions.dap.list_breakpoints()
          end,
          desc = "Frames",
        },
        {
          "<leader>ds",
          function()
            local widgets = require "dap.ui.widgets"
            widgets.centered_float(widgets.threads)
          end,
          desc = "Threads",
        },
        {
          "<leader>dS",
          function()
            local widgets = require "dap.ui.widgets"
            local my_sidebar = widgets.sidebar(widgets.scopes)
            my_sidebar.open()
          end,
          desc = "Sidebar",
        },
      },
      {
        "<leader>o",
        group = "Telescope",
        {
          "<leader>om",
          "<cmd>Noice history<CR>",
          desc = "Messages",
        },
        {
          "<leader>oh",
          "<cmd>Telescope help_tags<CR>",
          desc = "Help tags",
        },
        {
          "<leader>oc",
          "<cmd>Telescope colorscheme<CR>",
          desc = "Color Scheme",
        },
        {
          "<leader>ok",
          "<cmd>Telescope keymaps<CR>",
          desc = "Keymaps",
        },
        {
          "<leader>oo",
          require("telescope").extensions.recent_files.pick,
          desc = "Recent files",
        },
      },
      {
        "<leader>a",
        "<esc><cmd>lua require('lsp-fastaction').range_code_action()<CR>",
        desc = "Range code action",
        mode = { "v" },
      },
      {
        "<leader>e",
        "<esc><cmd>lua require('dapui').eval()<CR>",
        desc = "Debug eval",
        mode = { "v" },
      },
    },
  },
}
