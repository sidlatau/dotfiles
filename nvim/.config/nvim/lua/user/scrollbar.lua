local status_ok, scrollbar = pcall(require, "scrollbar")
if not status_ok then
  return
end

scrollbar.setup {
  handle = {
    color = "#1d2021",
  },
  marks = {
    Error = { highlight = "DiagnosticError" },
    Warn = { highlight = "DiagnosticSignWarning" },
    Info = { highlight = "DiagnosticSignInfo" },
    Hint = { highlight = "DiagnosticSignHing" },
    Mics = { highlight = "DiagnosticSignWarning" },
  },
}
