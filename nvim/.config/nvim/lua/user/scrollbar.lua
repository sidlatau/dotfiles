require("scrollbar").setup {
  handle = {
    highlight = "Background",
  },
  marks = {
    Error = { highlight = "DiagnosticError" },
    Warn = { highlight = "DiagnosticSignWarning" },
    Info = { highlight = "DiagnosticSignInfo" },
    Hint = { highlight = "DiagnosticSignHing" },
    Mics = { highlight = "DiagnosticSignWarning" },
  },
}
