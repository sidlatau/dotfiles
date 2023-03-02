local M = {}

local action_state = require "telescope.actions.state"
local actions = require "telescope.actions"
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

M.grep_string = function()
  local opts = {
    additional_args = function()
      return { "--hidden" }
    end,
    layout_config = { width = 0.8 },
  }
  require("telescope.builtin").grep_string(
    require("telescope.themes").get_dropdown { opts }
  )
end

M.git_status = function()
  require("telescope.builtin").git_status(
    require("telescope.themes").get_dropdown {}
  )
end

return M
