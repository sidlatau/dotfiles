local fn = vim.fn

return {
  "folke/noice.nvim",
  event = "VeryLazy",
  version = "*",
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {
    cmdline = {
      view = "cmdline",
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
      hover = { enabled = true },
      -- override markdown rendering so that cmp and other plugins use Treesitter
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
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
      mini = {
        timeout = 2000,
        win_options = {
          winhighlight = {
            Normal = "Normal",
          },
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
          },
        },
      },
    },
    commands = {
      history = { view = "vsplit" },
    },
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = true, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false, -- add a border to hover docs and signature help
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
