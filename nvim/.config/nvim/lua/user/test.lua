vim.g["test#dart#fluttertest#executable"] = "fvm flutter test"

require("neotest").setup {
  adapters = {
    require "neotest-vim-test" { ignore_filetypes = { "python", "lua" } },
  },
  icons = {
    running = "",
  },
}
