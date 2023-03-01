return {
  "rcarriga/nvim-notify",
  config = function()
    local notify = require "notify"

    notify.setup {
      stages = "fade_in_slide_out",
      timeout = 1000,
      minimum_width = 40,
      background_colour = "#282828",
    }
    vim.notify = notify
    require("telescope").load_extension "notify"
  end,
}
