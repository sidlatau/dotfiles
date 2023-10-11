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
    vim.g.db_ui_use_nvim_notify = 1
  end,
}
