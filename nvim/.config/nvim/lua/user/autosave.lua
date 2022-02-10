local status_ok, autosave = pcall(require, "autosave")
if not status_ok then
  return
end

autosave.setup {
  enabled = false,
  execution_message = function()
    return "AutoSave: saved at " .. vim.fn.strftime "%H:%M:%S"
  end,
  events = { "InsertLeave" },
  conditions = {
    exists = true,
    filename_is_not = {
      "plugins.lua",
    },
    filetype_is_not = {},
    modifiable = true,
  },
  write_all_buffers = true,
  on_off_commands = true,
  clean_command_line_interval = 1000,
  debounce_delay = 2000,
}
