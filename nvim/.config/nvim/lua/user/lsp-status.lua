local status_ok, lsp_status = pcall(require, "lsp-status")
if not status_ok then return end

lsp_status.register_progress()

lsp_status.config({
	indicator_info = "",
	indicator_errors = "",
	indicator_hint = "",
	status_symbol = "",
})
