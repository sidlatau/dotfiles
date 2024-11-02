return {
  "rmagatti/auto-session",
  enabled = true,
  config = function()
    require("auto-session").setup {
      log_level = "error",
      lazy_support = true,
      bypass_save_filetypes = { "log" },
      auto_session_suppress_dirs = {
        "~/",
        "~/Documents/github",
        "~/Downloads",
        "/",
      },
    }
  end,
}
