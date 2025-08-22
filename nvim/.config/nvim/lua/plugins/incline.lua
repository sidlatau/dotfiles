return {
  "b0o/incline.nvim",
  config = function()
    local devicons = require "nvim-web-devicons"
    require("incline").setup {
      window = {
        padding = 0,
        margin = { horizontal = 0 },
      },
      render = function(props)
        local filename =
          vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        if filename == "" then
          filename = "[No Name]"
        end
        local ft_icon, ft_color = devicons.get_icon_color(filename)

        local function get_diagnostic_label()
          local icons =
            { error = "", warn = "", info = "", hint = "" }
          local label = {}

          for severity, icon in pairs(icons) do
            local n = #vim.diagnostic.get(
              props.buf,
              { severity = vim.diagnostic.severity[string.upper(severity)] }
            )
            if n > 0 then
              table.insert(
                label,
                { icon .. n .. " ", group = "DiagnosticSign" .. severity }
              )
            end
          end
          if #label > 0 then
            table.insert(label, { "┊ " })
          end
          return label
        end
        local modified = vim.bo[props.buf].modified

        return {
          { get_diagnostic_label() },
          ft_icon and {
            modified and " ●" or "",
            " ",
            ft_icon,
            guifg = ft_color,
          } or "",
          " ",
          { filename, gui = "bold" },
          " ",
        }
      end,
    }
  end,
  event = "VeryLazy",
}
