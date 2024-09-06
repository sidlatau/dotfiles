local current_file = vim.fn.expand "%:t"
if current_file == "pubspec.yaml" then
  vim.keymap.set("n", "K", function()
    local line_string = vim.api.nvim_get_current_line()
    local function trim(s)
      return s:match "^%s*(.-)%s*$"
    end
    local package_name = trim(line_string):match "([^:]+):"
    local url = "https://pub.dev/packages/" .. package_name
    if package_name and url then
      vim.api.nvim_call_function("netrw#BrowseX", { url, 0 })
    end
  end, { buffer = 0 })
end
