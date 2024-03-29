return {
  "hrsh7th/nvim-cmp",
  event = "VeryLazy",
  config = function()
    local cmp_status_ok, cmp = pcall(require, "cmp")
    if not cmp_status_ok then
      return
    end

    local snip_status_ok, luasnip = pcall(require, "luasnip")
    if not snip_status_ok then
      return
    end

    local function tab(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.api.nvim_get_mode().mode == "c" then
        fallback()
      end
    end

    local function shift_tab(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.api.nvim_get_mode().mode == "c" then
        fallback()
      end
    end

    local kind_icons = {
      Text = "󰉿",
      Method = "󰆧",
      Function = "󰊕",
      Constructor = "",
      Field = "",
      Variable = "󰀫",
      Class = "",
      Interface = "",
      Module = "",
      Property = "",
      Unit = "",
      Value = "󰎠",
      Enum = "",
      Keyword = "󰌋",
      Snippet = "",
      Color = "󰏘",
      File = "󰈙",
      Reference = "󰈇",
      Folder = "󰉋",
      EnumMember = "",
      Constant = "󰏿",
      Struct = "",
      Event = "",
      Operator = "󰆕",
      TypeParameter = "",
    }

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      mapping = {
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping {
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        },
        ["<CR>"] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        ["<C-N>"] = cmp.mapping(tab, { "i", "c" }),
        ["<C-P>"] = cmp.mapping(shift_tab, { "i", "c" }),
      },
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          -- Kind icons
          vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
          -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
          vim_item.menu = ({
            nvim_lsp = "LSP",
            luasnip = "Snippet",
            buffer = "Buffer",
            path = "Path",
            ["vim-dadbod-completion"] = "DB",
          })[entry.source.name]
          return vim_item
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      },
      confirm_opts = { behavior = cmp.ConfirmBehavior.Replace, select = false },
      experimental = { ghost_text = false, native_menu = false },
    }

    local search_sources = {
      sources = cmp.config.sources({
        { name = "nvim_lsp_document_symbol" },
      }, {
        { name = "buffer" },
      }),
    }
    cmp.setup.cmdline("/", search_sources)
    cmp.setup.cmdline("?", search_sources)
    cmp.setup.cmdline(":", {
      sources = cmp.config.sources {
        { name = "cmdline" },
      },
    })

    local autocomplete_group =
      vim.api.nvim_create_augroup("vimrc_autocompletion", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "sql" },
      callback = function()
        cmp.setup.buffer {
          sources = {
            { name = "vim-dadbod-completion" },
            { name = "buffer" },
          },
        }
      end,
      group = autocomplete_group,
    })
  end,
}
