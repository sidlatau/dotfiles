return {
  "saghen/blink.cmp",
  lazy = false, -- lazy loading handled internally
  -- optional: provides snippets for the snippet source
  -- dependencies = "rafamadriz/friendly-snippets",

  -- use a release tag to download pre-built binaries
  -- version = "v0.*",
  -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  build = "cargo build --release",
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    -- see the "default configuration" section below for full documentation on how to define
    -- your own keymap.
    keymap = { preset = "enter" },

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- will be removed in a future release
      use_nvim_cmp_as_default = true,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono",
    },

    -- default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, via `opts_extend`
    sources = {
      default = {
        "lsp",
        "path",
        "lazydev",
        "dadbod",
        "luasnip",
        "buffer",
      },
      cmdline = {},
      providers = {
        -- dont show LuaLS require statements when lazydev has items
        lsp = { fallbacks = { "lazydev" } },
        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
        dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
      },
      -- Function to use when transforming the items before they're returned for all providers
      -- The default will lower the score for snippets to sort them lower in the list
      transform_items = function(_, items)
        for _, item in ipairs(items) do
          if
            item.kind == require("blink.cmp.types").CompletionItemKind.Snippet
            or item.kind == require("blink.cmp.types").CompletionItemKind.Text
          then
            item.score_offset = item.score_offset - 3
          end
        end
        return items
      end,
    },

    -- experimental auto-brackets support
    completion = {
      accept = { auto_brackets = { enabled = true } },
      menu = {
        border = "rounded",
        scrollbar = false,
      },
      documentation = {
        auto_show = true,
        window = { border = "rounded", scrollbar = false },
      },
      list = {
        selection = "auto_insert",
      },
    },

    -- experimental signature helghp support
    signature = { enabled = true, window = { border = "rounded" } },
    snippets = {
      expand = function(snippet)
        require("luasnip").lsp_expand(snippet)
      end,
      active = function(filter)
        if filter and filter.direction then
          return require("luasnip").jumpable(filter.direction)
        end
        return require("luasnip").in_snippet()
      end,
      jump = function(direction)
        require("luasnip").jump(direction)
      end,
    },
  },
  -- allows extending the enabled_providers array elsewhere in your config
  -- without having to redefine it
  opts_extend = { "sources.default" },
}
