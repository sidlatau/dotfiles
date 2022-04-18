local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

null_ls.setup {
  debug = false,
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.eslint_d.with {
      prefer_local = "node_modules/.bin",
    },
    null_ls.builtins.code_actions.eslint_d.with {
      prefer_local = "node_modules/.bin",
    },
    null_ls.builtins.formatting.prettierd,
  },
  on_attach = function(client)
    local ok, lsp_format = pcall(require, "lsp-format")
    if ok then
      lsp_format.on_attach(client)
    end
  end,
}
