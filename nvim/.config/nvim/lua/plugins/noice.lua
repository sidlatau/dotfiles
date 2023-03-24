local fn = vim.fn

return {
  "folke/noice.nvim",
  event = "VeryLazy",
  version = "*",
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {
    cmdline = {
      format = {
        cmdline = { title = "" },
        lua = { title = "" },
        search_down = { title = "" },
        search_up = { title = "" },
        filter = { title = "" },
        help = { title = "" },
        input = { title = "" },
        IncRename = { title = "" },
        substitute = {
          pattern = "^:%%?s/",
          icon = " ",
          ft = "regex",
          title = "",
        },
      },
    },
    lsp = {
      signature = {
        enabled = false,
      },
      hover = { enabled = false },
    },
    views = {
      vsplit = { size = { width = "auto" } },
      split = { win_options = { winhighlight = { Normal = "Normal" } } },
      cmdline_popup = {
        position = { row = 5, col = "50%" },
        size = { width = "auto", height = "auto" },
      },
      popupmenu = {
        relative = "editor",
        position = { row = 9, col = "50%" },
        size = { width = 60, height = 10 },
        win_options = {
          winhighlight = { Normal = "NormalFloat", FloatBorder = "FloatBorder" },
        },
      },
    },
    redirect = { view = "popup", filter = { event = "msg_show" } },
    routes = {
      {
        opts = { skip = true },
        filter = {
          any = {
            { event = "msg_show", find = "written" },
            { event = "msg_show", find = "%d+ lines, %d+ bytes" },
            { event = "msg_show", kind = "search_count" },
            { event = "msg_show", find = "%d+L, %d+B" },
            { event = "msg_show", find = "^Hunk %d+ of %d" },
            -- TODO: investigate the source of this LSP message and disable it happens in typescript files
            { event = "notify", find = "No information available" },
          },
        },
      },
      {
        view = "vsplit",
        filter = { event = "msg_show", min_height = 20 },
      },
      {
        view = "notify",
        filter = {
          any = {
            { event = "msg_show", min_height = 10 },
            { event = "msg_show", find = "Treesitter" },
          },
        },
        opts = { timeout = 10000 },
      },
      {
        view = "mini",
        filter = { any = { { event = "msg_show", find = "^E486:" } } }, -- minimise pattern not found messages
      },
      {
        view = "notify",
        filter = {
          any = {
            { warning = true },
            { event = "msg_show", find = "^Warn" },
            { event = "msg_show", find = "^W%d+:" },
            { event = "msg_show", find = "^No hunks$" },
          },
        },
        opts = { title = "Warning", merge = false, replace = false },
      },
      {
        view = "notify",
        opts = { title = "Error", merge = true, replace = false },
        filter = {
          any = {
            { error = true },
            { event = "msg_show", find = "^Error" },
            { event = "msg_show", find = "^E%d+:" },
          },
        },
      },
      {
        view = "notify",
        opts = { title = "" },
        filter = { kind = { "emsg", "echo", "echomsg" } },
      },
    },
    commands = {
      history = { view = "vsplit" },
    },
    presets = {
      inc_rename = true,
      long_message_to_split = true,
      lsp_doc_border = true,
    },
  },
  config = function(_, opts)
    require("noice").setup(opts)

    vim.keymap.set({ "n", "i", "s" }, "<c-f>", function()
      if not require("noice.lsp").scroll(4) then
        return "<c-f>"
      end
    end, { silent = true, expr = true })

    vim.keymap.set({ "n", "i", "s" }, "<c-b>", function()
      if not require("noice.lsp").scroll(-4) then
        return "<c-b>"
      end
    end, { silent = true, expr = true })

    vim.keymap.set("c", "<M-CR>", function()
      require("noice").redirect(fn.getcmdline())
    end, {
      desc = "redirect Cmdline",
    })
    require("telescope").load_extension "noice"
  end,
}
