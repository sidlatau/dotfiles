return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    explorer = {},
    input = { enabled = true },
    picker = {
      sources = {
        explorer = {
          hidden = true,
          layout = {
            layout = {
              backdrop = true,
              width = 60,
              min_width = 60,
              height = 0,
              position = "float",
              border = "rounded",
              box = "vertical",
              {
                win = "input",
                height = 1,
                border = "rounded",
                title = "{title} {live} {flags}",
                title_pos = "center",
              },
              { win = "list", border = "none" },
              {
                win = "preview",
                title = "{preview}",
                height = 0.4,
                border = "top",
              },
            },
          },
          auto_close = true,
          jump = { close = true },
        },
      },
    },
    quickfile = { enabled = true },
    words = {},
    scroll = {
      animate = {
        duration = { step = 15, total = 50 },
        easing = "inOutQuart",
      },
    },
    styles = {
      notification = {
        wo = { wrap = true }, -- Wrap notifications
        reverse = true,
      },
      lazygit = {
        width = 0,
        height = 0,
      },
    },
  },
  keys = {
    {
      "<leader>un",
      function()
        Snacks.notifier.hide()
      end,
      desc = "Dismiss All Notifications",
    },
    {
      "<leader>c",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete Buffer",
    },
    {
      "<leader>C",
      function()
        Snacks.bufdelete.other()
        vim.print "Deleted other buffers"
      end,
      desc = "Leave single Buffer",
    },
    {
      "<leader>gg",
      function()
        Snacks.lazygit()
      end,
      desc = "Lazygit",
    },
    {
      "<leader>gf",
      function()
        Snacks.lazygit.log_file()
      end,
      desc = "Lazygit Current File History",
    },
    {
      "<leader>gl",
      function()
        Snacks.lazygit.log()
      end,
      desc = "Lazygit Log (cwd)",
    },
    {
      "<leader>nh",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "Notification History",
    },
    {
      "<leader>N",
      desc = "Neovim News",
      function()
        Snacks.win {
          file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
          width = 0.6,
          height = 0.6,
          wo = {
            spell = false,
            wrap = false,
            signcolumn = "yes",
            statuscolumn = " ",
            conceallevel = 3,
          },
        }
      end,
    },
    {
      "<leader>.",
      function()
        Snacks.scratch()
      end,
      desc = "Toggle Scratch Buffer",
    },
    {
      "<leader>S",
      function()
        Snacks.scratch.select()
      end,
      desc = "Select Scratch Buffer",
    },
    {
      "<leader>z",
      function()
        Snacks.zen()
      end,
      desc = "Toggle Zen Mode",
    },
    {
      "<leader>Z",
      function()
        Snacks.zen.zoom()
      end,
      desc = "Toggle Zoom",
    },
    {
      "<leader>w",
      function()
        Snacks.explorer.open()
      end,
      desc = "Open explorer",
    },
  },
}
