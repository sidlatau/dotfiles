local status_ok, neotest = pcall(require, "neotest")
if not status_ok then
  return
end

neotest.setup {
  adapters = {
    require "neotest-dart" {
      command = "fvm flutter",
    },
    require "neotest-plenary",
  },
  output = {
    open_on_run = false,
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
