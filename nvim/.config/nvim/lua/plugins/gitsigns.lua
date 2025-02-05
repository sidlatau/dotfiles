return {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
  config = function()
    local gitsigns = require "gitsigns"

    gitsigns.setup {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
        interval = 1000,
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = true,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000,
      preview_config = {
        -- Options passed to nvim_open_win
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      on_attach = function(bufnr)
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gitsigns.nav_hunk "next"
          end)
          return "<Ignore>"
        end, { expr = true })

        map("n", "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gitsigns.nav_hunk "prev"
          end)
          return "<Ignore>"
        end, { expr = true })
      end,
    }
  end,
  keys = {
    {
      "<leader>hs",
      "<cmd>lua require('gitsigns').stage_hunk()<cr>",
      desc = "Stage hunk",
    },
    {
      "<leader>hr",
      "<cmd>lua require('gitsigns').reset_hunk()<cr>",
      desc = "Reset hunk",
    },
    {
      "<leader>hS",
      "<cmd>lua require('gitsigns').stage_buffer()<cr>",
      desc = "Stage buffer",
    },
    {
      "<leader>hu",
      "<cmd>lua require('gitsigns').undo_stage_hunk()<cr>",
      desc = "Undo stage hunk",
    },
    {
      "<leader>gR",
      "<cmd>lua require('gitsigns').reset_buffer()<cr>",
      desc = "Reset buffer",
    },
    {
      "<leader>hp",
      "<cmd>lua require('gitsigns').preview_hunk()<cr>",
      desc = "Preview hunk",
    },
    {
      "<leader>gb",
      "<cmd>lua require('gitsigns').blame_line({full = true})<cr>",
      desc = "Blame line",
    },
    {
      "<leader>tb",
      "<cmd>lua require('gitsigns').toggle_current_line_blame()<cr>",
      desc = "Toggle blame line",
    },
    {
      "<leader>hd",
      "<cmd>lua require('gitsigns').diffthis()<cr>",
      desc = "Diff this",
    },
    {
      "<leader>hD",
      "<cmd>lua require('gitsigns').diffthis('~')<cr>",
      desc = "Diff this (cached)",
    },
    {
      "<leader>gz",
      function()
        require("gitsigns").preview_hunk_inline()
      end,
      desc = "Toggle deleted",
    },
  },
}
