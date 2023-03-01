return {
  "ray-x/lsp_signature.nvim",
  config = function()
    local signature_config = {
      hint_enable = false,
      toggle_key = "<C-x>",
    }
    require("lsp_signature").setup(signature_config)
  end,
}
