local status_ok, notify = pcall(require, "notify")
if not status_ok then
  return
end

notify.setup {
  stages = "fade_in_slide_out",
  timeout = 3000,
  minimum_width = 40,
  background_colour = "#282828",
}
vim.notify = notify
require("telescope").load_extension "notify"
