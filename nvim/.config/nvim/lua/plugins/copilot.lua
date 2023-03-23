return {
  "github/copilot.vim",
  config = function()
    vim.g.copilot_filetypes = {
      ["*"] = true,
      gitcommit = false,
      DressingInput = false,
      TelescopePrompt = false,
      ["neo-tree-popup"] = false,
      ["dap-repl"] = false,
    }
  end,
}
