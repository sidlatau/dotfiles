local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local diff = {
  "diff",
  colored = false,
  symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width,
}

local mode = {
  "mode",
  fmt = function(str)
    return " " .. str .. " "
  end,
}

local filetype = {
  "filetype",
  icons_enabled = false,
  icon = nil,
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = "",
}

local location = {
  "location",
  padding = 0,
}

local spaces = function()
  return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local function workspace_diagnostic()
  local error_count, warning_count, info_count, hint_count
  local count = { 0, 0, 0, 0 }
  local diagnostics = vim.diagnostic.get(nil)
  for _, diagnostic in ipairs(diagnostics) do
    if
      vim.startswith(
        vim.diagnostic.get_namespace(diagnostic.namespace).name,
        "vim.lsp"
      )
    then
      count[diagnostic.severity] = count[diagnostic.severity] + 1
    end
  end
  error_count = count[vim.diagnostic.severity.ERROR]
  warning_count = count[vim.diagnostic.severity.WARN]
  info_count = count[vim.diagnostic.severity.INFO]
  hint_count = count[vim.diagnostic.severity.HINT]

  local str = ""
  if error_count > 0 then
    if string.len(str) > 0 then
      str = str .. " "
    end
    str = str .. " " .. error_count
  end
  if warning_count > 0 then
    if string.len(str) > 0 then
      str = str .. " "
    end
    str = str .. " " .. warning_count
  end
  if info_count > 0 then
    if string.len(str) > 0 then
      str = str .. " "
    end
    str = str .. " " .. info_count
  end
  if hint_count > 0 then
    if string.len(str) > 0 then
      str = str .. " "
    end
    str = str .. " " .. hint_count
  end

  return str
end

local function lsp_client()
  local names = {}
  for _, client in ipairs(vim.lsp.buf_get_clients(0)) do
    if client.name then
      table.insert(names, client.name)
    end
  end
  if #names == 0 then
    return ""
  end
  return table.concat(names, ", ")
end
local ultest = {
  function()
    local status = vim.api.nvim_eval "ultest#status()"

    local sections = {
      {
        sign = vim.g.ultest_fail_sign,
        count = status.failed,
        base = "UltestFail",
        tag = "test_fail",
      },
      {
        sign = vim.g.ultest_running_sign,
        count = status.running,
        base = "UltestRunning",
        tag = "test_running",
      },
      {
        sign = vim.g.ultest_pass_sign,
        count = status.passed,
        base = "UltestPass",
        tag = "test_pass",
      },
    }

    local result = {}
    for _, section in ipairs(sections) do
      if section.count > 0 then
        table.insert(
          result,
          "%#" .. section.base .. "#" .. section.sign .. section.count
        )
      end
    end

    return table.concat(result, " ")
  end,
  cond = function()
    local is_ok, is_test = pcall(vim.api.nvim_eval, "ultest#is_test_file()")
    return is_ok and is_test == 1
  end,
}

lualine.setup {
  options = {
    icons_enabled = true,
    theme = "gruvbox-material",
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    disabled_filetypes = { "Outline" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { branch, workspace_diagnostic },
    lualine_b = { mode },
    lualine_c = { ultest },
    lualine_x = {
      diff,
      spaces,
      "encoding",
      filetype,
    },
    lualine_y = { location },
    lualine_z = { lsp_client },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {
    lualine_c = { "filename" },
  },
  extensions = {},
}
