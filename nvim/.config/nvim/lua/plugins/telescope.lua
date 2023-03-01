return {
  "nvim-telescope/telescope.nvim",
  config = function()
    local telescope = require "telescope"
    -- Register filetypes via plenary for telescope previewers
    -- https://github.com/nvim-lua/plenary.nvim#plenaryfiletype
    require("plenary.filetype").add_file "filetypes"

    telescope.setup {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },
        file_ignore_patterns = { "%.g.dart", "%.freezed.dart" },
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
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
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
