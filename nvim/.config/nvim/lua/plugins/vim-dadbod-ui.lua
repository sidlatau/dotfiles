return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    {
      "kristijanhusak/vim-dadbod-completion",
      ft = { "sql", "sqlite" },
      lazy = true,
    },
  },
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_show_database_icon = 1
    vim.g.db_ui_use_nvim_notify = 1
    vim.g.db_ui_auto_execute_table_helpers = 1
    vim.g.db_ui_execute_on_save = 1
    vim.g.dbs = {
      {
        name = "HH-local",
        url = "sqlserver://sa:<YourStrong%40Password123>@localhost:1433/hh-stage-db?trustServerCertificate=true",
      },
    }
  end,
}
