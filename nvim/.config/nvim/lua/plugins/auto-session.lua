return {
  "rmagatti/auto-session",
  enabled = true,
  config = function()
    require("auto-session").setup {
      bypass_save_filetypes = { "log", "copilot-chat" },
      lazy_support = true,
      log_level = "error",
      suppressed_dirs = { "~/", "~/Documents/github", "~/Downloads", "/" },
    }
  end,
}
