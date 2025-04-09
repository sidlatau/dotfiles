return {
  "MagicDuck/grug-far.nvim",
  config = function()
    require("grug-far").setup {
      -- options, see Configuration section below
      -- there are no required options atm
      -- engine = 'ripgrep' is default, but 'astgrep' can be specified
    }
  end,
  keys = {
    {
      "<leader>r",
      function()
        require("grug-far").toggle_instance {
          instanceName = "far",
          staticTitle = "Find and Replace",
        }
      end,
      desc = "Grug Far - search and replace",
    },
  },
}
