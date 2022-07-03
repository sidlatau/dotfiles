vim.g["test#dart#fluttertest#executable"] = "fvm flutter test"

require("neotest").setup {
  adapters = {
    require "neotest-dart" {
      command = "fvm flutter",
    },
    require "neotest-vim-test" {
      ignore_filetypes = { "python", "lua", "dart" },
    },
  },
  icons = {
    running = "",
  },
}
