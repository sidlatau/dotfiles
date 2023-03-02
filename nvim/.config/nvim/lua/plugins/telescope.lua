return {
  "nvim-telescope/telescope.nvim",
  config = function()
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
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },
        file_ignore_patterns = { "%.g.dart", "%.freezed.dart" },
        -- `hidden = true` is not supported in text grep commands.
        vimgrep_arguments = vimgrep_arguments,
        preview = {
          mime_hook = function(filepath, bufnr, opts)
            local is_image = function(imagePath)
              local image_extensions = { "png", "jpg", "jpeg", "gif" } -- Supported image formats
              local split_path =
                vim.split(imagePath:lower(), ".", { plain = true })
              local extension = split_path[#split_path]
              return vim.tbl_contains(image_extensions, extension)
            end
            if is_image(filepath) then
              local term = vim.api.nvim_open_term(bufnr, {})
              local function send_output(_, data, _)
                for _, d in ipairs(data) do
                  vim.api.nvim_chan_send(term, d .. "\r\n")
                end
              end

              vim.fn.jobstart({
                "viu",
                "-b",
                filepath,
              }, {
                on_stdout = send_output,
                stdout_buffered = true,
              })
            else
              require("telescope.previewers.utils").set_preview_message(
                bufnr,
                opts.winid,
                "Binary cannot be previewed"
              )
            end
          end,
        },
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
      },
      mappings = {
        i = {
          ["<C-k"] = require("telescope.actions").cycle_history_next,
          ["<C-j>"] = require("telescope.actions").cycle_history_prev,
        },
      },
    }

    require("telescope").load_extension "dap"
    require("telescope").load_extension "fzf"
    require("telescope").load_extension "recent_files"
  end,
}
