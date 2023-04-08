return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  config = function()
    local lualine = require "lualine"

    local colors = {
      bg = "#202328",
      fg = "#bbc2cf",
      yellow = "#ECBE7B",
      cyan = "#008080",
      darkblue = "#081633",
      green = "#98be65",
      orange = "#FF8800",
      violet = "#a9a1e1",
      magenta = "#c678dd",
      blue = "#51afef",
      red = "#ec5f67",
    }

    local hide_in_width = function()
      return vim.fn.winwidth(0) > 80
    end

    local diff = {
      "diff",
      cond = hide_in_width,
      symbols = { added = " ", modified = "柳 ", removed = " " },
    }

    local mode = {
      "mode",
      fmt = function(str)
        return " " .. str .. " "
      end,
    }

    local filetype = {
      "filetype",
    }

    local branch = {
      "branch",
      icon = "",
      separator = { left = "", right = "" },
    }
    local status_counts = {
      function()
        local status_ok, neotest = pcall(require, "neotest")
        if not status_ok then
          return ""
        end
        local adapters = neotest.state.adapter_ids()
        if #adapters > 0 then
          local status = neotest.state.status_counts(adapters[1], {
            buffer = vim.api.nvim_buf_get_name(0),
          })
          local sections = {
            {
              sign = "",
              count = status.failed,
              base = "NeotestFailed",
              tag = "test_fail",
            },
            {
              sign = "",
              count = status.running,
              base = "NeotestRunning",
              tag = "test_running",
            },
            {
              sign = "",
              count = status.passed,
              base = "NeotestPassed",
              tag = "test_pass",
            },
          }

          local result = {}
          for _, section in ipairs(sections) do
            if section.count > 0 then
              table.insert(
                result,
                "%#"
                  .. section.base
                  .. "#"
                  .. section.sign
                  .. " "
                  .. section.count
              )
            end
          end

          return table.concat(result, " ")
        end
        return ""
      end,
    }

    local lsp_client = {
      function()
        local names = {}
        local msg = "No Active Lsp"
        local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            table.insert(names, client.name)
          end
        end
        return table.concat(names, ", ")
      end,
      icon = " ",
      color = { fg = colors.green, gui = "bold" },
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
        lualine_a = { branch },
        lualine_b = { mode },
        lualine_c = {
          { "diagnostics", sources = { "nvim_workspace_diagnostic" } },
          status_counts,
        },
        lualine_x = {
          {
            require("noice").api.status.mode.get,
            cond = require("noice").api.status.mode.has,
            color = { fg = "#ff9e64" },
          },
          diff,
          filetype,
          lsp_client,
        },
        lualine_y = {
          {
            "location",
            separator = { left = "", right = "" },
          },
        },
        lualine_z = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { "neo-tree", "toggleterm", "fugitive" },
    }
  end,
}
