return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix",
    -- icons = { rules = false },
    delay = 600,
    triggers = {
      { "<leader>", mode = { "n", "v" } },
    },
    plugins = {
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
        "<leader>f",
        group = "Flutter",
      },
      {
        "<leader>g",
        group = "Git",
        {
          "<leader>gF",
          "<cmd>!fork<cr>",
          desc = "Open Fork",
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
          desc = "Open changed files",
        },
        {
          "<leader>gC",
          "<cmd>Telescope advanced_git_search search_log_content<cr>",
          desc = "Git log",
        },
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
