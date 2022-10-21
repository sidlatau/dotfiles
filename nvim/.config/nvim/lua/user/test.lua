require("neotest").setup {
  adapters = {
    require "neotest-dart" {
      command = "fvm flutter",
    },
    require "neotest-plenary",
  },
  icons = {
    expanded = "",
    child_prefix = "",
    child_indent = "",
    final_child_prefix = "",
    non_collapsible = "",
    collapsed = "",

    passed = "",
    running = "",
    failed = "",
    unknown = "",
  },
}
