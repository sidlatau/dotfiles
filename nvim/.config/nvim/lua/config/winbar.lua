local M = {}

local get_filename = function()
  local path = vim.fn.expand "%:p"
  if string.find(path, "scratch") then
    return nil
  end
  local filename = vim.fn.expand "%:t"
  local extension = vim.fn.expand "%:e"
  local f = require "config.functions"

  if not f.isempty(filename) then
    local file_icon, file_icon_color =
      require("nvim-web-devicons").get_icon_color(
        filename,
        extension,
        { default = true }
      )

    local hl_group = "FileIconColor_" .. extension

    vim.api.nvim_set_hl(0, hl_group, { fg = file_icon_color })
    if f.isempty(file_icon) then
      file_icon = ""
      file_icon_color = ""
    end

    return " "
      .. "%#"
      .. hl_group
      .. "#"
      .. file_icon
      .. "%*"
      .. " "
      .. "%#Normal#"
      .. filename
      .. "%*"
  end
end

M.get_winbar = function()
  -- Check the buffer type of the current window
  if vim.bo[0].buftype ~= "" then
    return
  end

  -- Check if the window is high enough for a winbar
  if vim.api.nvim_win_get_height(0) < 2 then
    return
  end

  local f = require "config.functions"
  local value = get_filename()

  if not f.isempty(value) then
    if vim.api.nvim_get_option_value("mod", { buf = 0 }) then
      local mod = "%#Normal#" .. require("config.icons").ui.Circle .. "%*"
      value = value .. " " .. mod
    end
  else
    return
  end

  local status_ok, err =
    pcall(vim.api.nvim_set_option_value, "winbar", value, { scope = "local" })
  if not status_ok then
    vim.print("Failed to set winbar: " .. tostring(err))
    return
  end
end
return M
