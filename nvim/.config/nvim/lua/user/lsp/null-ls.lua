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
    null_ls.builtins.formatting.prettier.with {
      -- prefer_local = "node_modules/.bin",
    },
    -- null_ls.builtins.diagnostics.eslint_d,
    -- null_ls.builtins.code_actions.eslint_d,
  },
}
