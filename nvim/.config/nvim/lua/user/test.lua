local status_ok, neotest = pcall(require, "neotest")
if not status_ok then
  return
end

local namespace = vim.api.nvim_create_namespace "neotest"
vim.diagnostic.config({
  virtual_text = {
    format = function(diagnostic)
      vim.pretty_print(diagnostic)
      return diagnostic.message
        :gsub("\n", " ")
        :gsub("\t", " ")
        :gsub("%s+", " ")
        :gsub("^%s+", "")
    end,
  },
}, namespace)

neotest.setup {
  adapters = {
    require "neotest-dart" {
      command = "fvm flutter",
    },
    require "neotest-plenary",
  },
  discovery = {
    enabled = false,
  },
  diagnostic = {
    enabled = true,
  },
  floating = {
    border = "rounded",
    max_height = 0.8,
    max_width = 0.8,
    options = {},
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
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "]n", function()
  neotest.jump.next { status = "failed" }
end, opts)
vim.keymap.set("n", "[n", function()
  neotest.jump.prev { status = "failed" }
end, opts)
vim.keymap.set("n", "]t", neotest.jump.next, opts)
vim.keymap.set("n", "[t", neotest.jump.prev, opts)
