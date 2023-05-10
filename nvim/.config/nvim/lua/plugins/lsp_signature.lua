return {
  "ray-x/lsp_signature.nvim",
  event = "VeryLazy",
  enabled = false,
  config = function()
    local signature_config = {
      hint_enable = false,
      toggle_key = "<C-s>",
      noice = true,
    }
    require("lsp_signature").setup(signature_config)
  end,
}
