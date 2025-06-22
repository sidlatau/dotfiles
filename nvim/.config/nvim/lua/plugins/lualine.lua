return {
  "nvim-lualine/lualine.nvim",
  config = function()
    local dmode_enabled = false
    vim.api.nvim_create_autocmd("User", {
      pattern = "DebugModeChanged",
      callback = function(args)
        dmode_enabled = args.data.enabled
      end,
    })
    local lualine = require "lualine"

    local colors = {
      green = "#98be65",
    }

    local hide_in_width = function()
      return vim.fn.winwidth(0) > 80
    end

    local diff = {
      "diff",
      cond = hide_in_width,
      symbols = { added = " ", modified = " ", removed = " " },
    }

    local mode = {
      "mode",
      fmt = function(str)
        return dmode_enabled and "DEBUG" or str
      end,
      color = function(tb)
        return dmode_enabled and "dCursor" or tb
      end,
    }

    local filetype = {
      "filetype",
    }

    local branch = {
      "branch",
      icon = "",
      separator = { left = "", right = "" },
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
            buffer = tonumber(vim.api.nvim_buf_get_name(0)),
          })
          local sections = {
            {
              sign = "",
              count = status and status.failed or "-",
              base = "NeotestFailed",
              tag = "test_fail",
            },
            {
              sign = "",
              count = status and status.running or "-",
              base = "NeotestRunning",
              tag = "test_running",
            },
            {
              sign = "",
              count = status and status.passed or "-",
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
        local clients = vim.lsp.get_clients()
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          table.insert(names, client.name)
        end
        return table.concat(names, ", ")
      end,
      icon = " ",
      color = { fg = colors.green, gui = "bold" },
    }

    local flutter_project_config = {
      function()
        local decorations = vim.g.flutter_tools_decorations or {}
        local project_config = decorations.project_config or {}
        return project_config.name or ""
      end,
      color = { fg = colors.green, gui = "bold" },
    }

    lualine.setup {
      options = {
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        disabled_filetypes = { "Outline" },
        always_divide_middle = true,
        globalstatus = true,
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { mode },
        lualine_b = { branch },
        lualine_c = {
          { "diagnostics", sources = { "nvim_workspace_diagnostic" } },
          status_counts,
        },
        lualine_x = {
          flutter_project_config,
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
