return {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  config = function()
    local yank_selected_entry = function(prompt_bufnr)
      local action_state = require "telescope.actions.state"
      local entry_display = require "telescope.pickers.entry_display"
      local actions = require "telescope.actions"

      local picker = action_state.get_current_picker(prompt_bufnr)
      local manager = picker.manager

      local selection_row = picker:get_selection_row()
      local entry = manager:get_entry(picker:get_index(selection_row))
      local display, _ = entry_display.resolve(picker, entry)

      actions.close(prompt_bufnr)

      vim.fn.setreg("+", display)
    end

    local telescope = require "telescope"
    local telescopeConfig = require "telescope.config"
    -- Register filetypes via plenary for telescope previewers
    -- https://github.com/nvim-lua/plenary.nvim#plenaryfiletype
    require("plenary.filetype").add_file "filetypes"

    -- Clone the default Telescope configuration
    local vimgrep_arguments =
      { unpack(telescopeConfig.values.vimgrep_arguments) }

    -- I want to search in hidden/dot files.
    table.insert(vimgrep_arguments, "--hidden")
    -- I don't want to search in the `.git` directory.
    table.insert(vimgrep_arguments, "--glob")
    table.insert(vimgrep_arguments, "!**/.git/*")

    telescope.setup {
      defaults = require("telescope.themes").get_dropdown {
        layout_config = {
          preview_cutoff = 1, -- Preview should always show (unless previewer = false)

          width = function(_, max_columns, _)
            return math.min(max_columns, 100)
          end,
        },
        mappings = {
          i = {
            ["<C-k"] = require("telescope.actions").cycle_history_next,
            ["<C-j>"] = require("telescope.actions").cycle_history_prev,
            ["<c-y>"] = yank_selected_entry,
          },
          n = {
            ["<c-y>"] = yank_selected_entry,
          },
        },
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },
        file_ignore_patterns = { "%.g.dart", "%.freezed.dart" },
        -- `hidden = true` is not supported in text grep commands.
        vimgrep_arguments = vimgrep_arguments,
      },
      pickers = {
        find_files = {
          find_command = {
            "fd",
            "--type",
            "file",
            "--type",
            "symlink",
            "--hidden",
            "--exclude",
            ".git",
            -- put your other patterns here
          },
        },
      },
      extensions = {
        recent_files = {
          only_cwd = true,
        },
        advanced_git_search = {},
        fzf = {},
      },
    }

    require("telescope").load_extension "dap"
    require("telescope").load_extension "fzf"
    require("telescope").load_extension "recent_files"
    require("telescope").load_extension "advanced_git_search"
  end,
  keys = {
    {
      "<leader>R",
      "<cmd>Telescope resume<cr>",
      desc = "Telescope resume",
    },
    {
      "<leader>ot",
      "<cmd>Telescope colorscheme<CR>",
      desc = "Color Scheme",
    },
    {
      "<leader>oo",
      require("telescope").extensions.recent_files.pick,
      desc = "Recent files",
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
              layout_config = { width = 0.9 },
            },
          }
        )
      end,
      desc = "Word under cursor",
    },
    {
      "<leader>sn",
      function()
        local opts = {
          cwd = vim.fn.stdpath "config",
        }

        require("telescope.builtin").find_files(opts)
      end,
      desc = "Neovim config",
    },
    {
      "<leader>sp",
      function()
        local opts = {
          cwd = vim.fs.joinpath(vim.fn.stdpath "data", "lazy"),
        }

        require("telescope.builtin").find_files(opts)
      end,
      desc = "Neovim config",
    },
    {
      "<leader>F",
      function()
        require("config.telescope").live_multigrep()
      end,
      desc = "Find Text",
    },
  },
}
