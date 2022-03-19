local status_ok, notify = pcall(require, "notify")
if not status_ok then
  return
end

---@type table<string, fun(bufnr: number, notif: table, highlights: table)>
local renderer = require "notify.render"
notify.setup {
  stages = "fade_in_slide_out",
  timeout = 3000,
  minimum_width = 40,
  background_colour = "#282828",
  render = function(bufnr, notif, highlights)
    if notif.title[1] == "" then
      return renderer.minimal(bufnr, notif, highlights)
    end
    return renderer.default(bufnr, notif, highlights)
  end,
}
vim.notify = notify
require("telescope").load_extension "notify"
