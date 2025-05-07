local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

mason.setup()

local mason_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_status_ok then
  return
end

mason_lspconfig.setup {
  ensure_installed = {
    "jsonls",
    "lua_ls",
    "yamlls",
    "eslint",
    "ts_ls",
  },
}
