return {
  "chrisgrieser/nvim-spider",
  lazy = true,
  init = function()
    vim.keymap.set(
      { "n", "o", "x" },
      "w",
      "<cmd>lua require('spider').motion('w',{ skipInsignificantPunctuation = true })<CR>",
      { desc = "Spider-w" }
    )
    vim.keymap.set(
      { "n", "o", "x" },
      "e",
      "<cmd>lua require('spider').motion('e')<CR>",
      { desc = "Spider-e" }
    )
    vim.keymap.set(
      { "n", "o", "x" },
      "b",
      "<cmd>lua require('spider').motion('b')<CR>",
      { desc = "Spider-b" }
    )
  end,
}
