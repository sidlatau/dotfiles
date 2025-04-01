return {
  "nvim-neotest/neotest",
  dev = true,
  dependencies = {
    "nvim-neotest/neotest-plenary",
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    local status_ok, neotest = pcall(require, "neotest")
    if not status_ok then
      return
    end

    neotest.setup {
      -- log_level = vim.log.levels.DEBUG,
      adapters = {
        require "neotest-dart" {
          command = "fvm flutter",
          custom_test_method_names = { "testWidgetsWithDeps", "testWithDeps" },
        },
        require "neotest-plenary",
      },
      output = {
        open_on_run = false,
      },
      discovery = {
        enabled = false,
      },
      diagnostic = {
        enabled = true,
      },
      floating = {
        border = "rounded",
        max_height = 0.8,
        max_width = 0.8,
        options = {},
      },
      quickfix = {
        enabled = false,
      },
      state = {
        enabled = true,
      },
      watch = {
        symbol_queries = {
          dart = "",
        },
      },
    }
    local opts = { noremap = true, silent = true }

    vim.keymap.set("n", "]n", function()
      neotest.jump.next { status = "failed" }
    end, opts)
    vim.keymap.set("n", "[n", function()
      neotest.jump.prev { status = "failed" }
    end, opts)
    vim.keymap.set("n", "]t", neotest.jump.next, opts)
    vim.keymap.set("n", "[t", neotest.jump.prev, opts)
  end,
  keys = {
    {
      "<leader>tf",
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
        require("neotest").output_panel.toggle()
      end,
      desc = "Test panel",
    },
    {
      "<leader>tt",
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
    {
      "<leader>tw",
      function()
        require("neotest").watch.toggle()
      end,
      desc = "Watch",
    },
  },
}
