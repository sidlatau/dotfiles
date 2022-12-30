local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end
-- Register filetypes via plenary for telescope previewers
-- https://github.com/nvim-lua/plenary.nvim#plenaryfiletype
require("plenary.filetype").add_file "filetypes"

local actions = require "telescope.actions"

telescope.setup {
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
    file_ignore_patterns = { "%.g.dart", "%.freezed.dart" },
    preview = {
      mime_hook = function(filepath, bufnr, opts)
        local is_image = function(filepath)
          local image_extensions = { "png", "jpg", "jpeg", "gif" } -- Supported image formats
          local split_path = vim.split(filepath:lower(), ".", { plain = true })
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

local action_state = require "telescope.actions.state"

local M = {}

M.sorted_buffers = function(opts)
  opts = opts or {}
  opts.attach_mappings = function(prompt_bufnr, map)
    local delete_buf = function()
      local selection = action_state.get_selected_entry()
      actions.close(prompt_bufnr)
      vim.api.nvim_buf_delete(selection.bufnr, { force = true })
    end
    map("i", "<c-x>", delete_buf)
    return true
  end
  opts.previewer = false
  -- define more opts here
  -- opts.show_all_buffers = true
  opts.sort_mru = true
  -- opts.shorten_path = false
  require("telescope.builtin").buffers(
    require("telescope.themes").get_dropdown(opts)
  )
end

M.find_files = function()
  local opts = {
    hidden = true,
  }
  require("telescope.builtin").find_files(
    require("telescope.themes").get_dropdown(opts)
  )
end

M.live_grep = function()
  local opts = {
    additional_args = function()
      return { "--hidden" }
    end,
  }
  require("telescope.builtin").live_grep(
    require("telescope.themes").get_dropdown(opts)
  )
end

return M
