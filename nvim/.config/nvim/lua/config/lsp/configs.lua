local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

local neodev_status_ok, neodev = pcall(require, "neodev")
if neodev_status_ok then
  neodev.setup {}
end

mason.setup()
local mason_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_status_ok then
  return
end
local lspconfig = require "lspconfig"

local servers = {
  "jsonls",
  "lua_ls",
  "yamlls",
  "gopls",
  "eslint",
  "tsserver",
  "pyright",
}

mason_lspconfig.setup {
  ensure_installed = servers,
}

for _, server in pairs(servers) do
  local opts = {
    on_attach = require("config.lsp.handlers").on_attach,
    capabilities = require("config.lsp.handlers").capabilities,
  }
  local has_custom_opts, server_custom_opts =
    pcall(require, "config.lsp.settings." .. server)
  if has_custom_opts then
    opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
  end
  lspconfig[server].setup(opts)
end
