return function()
  require("tint").setup {
    tint = -45, -- Darken colors, use a positive value to brighten
    saturation = 0.6, -- Saturation to preserve
    transforms = require("tint").transforms.SATURATE_TINT, -- Showing default behavior, but value here can be predefined set of transforms
    tint_background_colors = true, -- Tint background portions of highlight groups
    highlight_ignore_patterns = { "WinSeparator", "Status.*", "Telescope.*" }, -- Highlight group patterns to ignore, see `string.find`
    window_ignore_function = function(winid)
      local bufid = vim.api.nvim_win_get_buf(winid)
      local floating = vim.api.nvim_win_get_config(winid).relative ~= ""
      local functions = require "user.functions"

      local b = vim.bo[bufid]
      local ignore_bt = { "terminal", "prompt", "nofile" }
      local ignore_ft = {
        "neo-tree",
        "packer",
        "diff",
        "toggleterm",
        "Neogit.*",
        "Telescope.*",
      }
      return vim.tbl_contains(ignore_bt, b.bt)
        or vim.tbl_contains(ignore_ft, b.ft)
        or floating
    end,
  }
end
