local M = {}

M.winbar_filetype_exclude = {
  "help",
  "startify",
  "dashboard",
  "packer",
  "neogitstatus",
  "NvimTree",
  "Trouble",
  "alpha",
  "lir",
  "Outline",
  "spectre_panel",
  "toggleterm",
  "neo-tree",
  "dap-float",
}

local get_filename = function()
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

    local hl_group = "FileIconColor" .. extension

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

local excludes = function()
  if vim.tbl_contains(M.winbar_filetype_exclude, vim.bo.filetype) then
    vim.opt_local.winbar = nil
    return true
  end
  return false
end

M.get_winbar = function()
  if excludes() then
    return
  end
  local f = require "config.functions"
  local value = get_filename()

  if
    not f.isempty(value) and vim.api.nvim_get_option_value("mod", { buf = 0 })
  then
    local mod = "%#Normal#" .. require("config.icons").ui.Circle .. "%*"
    value = value .. " " .. mod
  end

  local status_ok, _ =
    pcall(vim.api.nvim_set_option_value, "winbar", value, { scope = "local" })
  if not status_ok then
    return
  end
end

return M
