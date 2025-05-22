return {
  "ThePrimeagen/harpoon",
  -- branch = "harpoon2",
  event = "VeryLazy",
  opt = {},
  keys = {
    {
      "<leader>ha",
      function()
        require("harpoon.mark").add_file()
      end,
      desc = "Add",
    },
    {
      "<leader>hh",
      function()
        require("harpoon.ui").toggle_quick_menu()
      end,
      desc = "Edit",
    },
    {
      "<leader>1",
      function()
        require("harpoon.ui").nav_file(1)
      end,
      desc = "Nav 1",
    },
    {
      "<leader>2",
      function()
        require("harpoon.ui").nav_file(2)
      end,
      desc = "Nav 2",
    },
    {
      "<leader>3",
      function()
        require("harpoon.ui").nav_file(3)
      end,
      desc = "Nav 3",
    },
    {
      "<leader>4",
      function()
        require("harpoon.ui").nav_file(4)
      end,
      desc = "Nav 4",
    },
    {
      "<leader>5",
      function()
        require("harpoon.ui").nav_file(5)
      end,
      desc = "Nav 5",
    },
  },
}
