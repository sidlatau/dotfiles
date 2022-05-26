require "dap"
vim.fn.sign_define(
  "DapBreakpoint",
  { text = " ", texthl = "debugBreakpoint", linehl = "", numhl = "" }
)
vim.fn.sign_define(
  "DapBreakpointCondition",
  { text = " ", texthl = "DiagnosticWarn", linehl = "", numhl = "" }
)
vim.fn.sign_define(
  "DapBreakpointRejected",
  { text = " ", texthl = "DiagnosticError", linehl = "", numhl = "" }
)
vim.fn.sign_define(
  "DapLogPoint",
  { text = " ", texthl = "debugBreakpoint", linehl = "", numhl = "" }
)
vim.fn.sign_define(
  "DapStopped",
  { text = "", texthl = "debugBreakpoint", linehl = "debugPC", numhl = "" }
)
