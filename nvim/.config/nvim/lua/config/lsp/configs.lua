local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

mason.setup()
local mason_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_status_ok then
  return
end
local lspconfig = require "lspconfig"

mason_lspconfig.setup {
  ensure_installed = {
    "jsonls",
    "lua_ls",
    "yamlls",
    "eslint",
    "tsserver",
  },
}
-- automatically install ensure_installed servers
require("mason-lspconfig").setup_handlers {
  -- Will be called for each installed server that doesn't have
  -- a dedicated handler.
  --
  function(server_name) -- default handler (optional)
    -- https://github.com/neovim/nvim-lspconfig/pull/3232
    if server_name == "tsserver" then
      server_name = "ts_ls"
    end
    local opts = {
      on_attach = require("config.lsp.handlers").on_attach,
      capabilities = require("config.lsp.handlers").capabilities,
    }
    local has_custom_opts, server_custom_opts =
      pcall(require, "config.lsp.settings." .. server_name)
    if has_custom_opts then
      opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
    end
    lspconfig[server_name].setup(opts)
  end,
}
