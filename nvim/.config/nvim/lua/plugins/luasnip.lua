return {
  "L3MON4D3/LuaSnip",
  build = "make install_jsregexp",
  event = "VeryLazy",
  config = function()
    local luasnip = require "luasnip"

    luasnip.config.set_config {
      -- This tells LuaSnip to remember to keep around the last snippet.
      -- You can jump back into it even if you move outside of the selection
      history = true,
      -- This one is cool cause if you have dynamic snippets, it updates as you type!
      updateevents = "TextChanged,TextChangedI",
      enable_autosnippets = true,
    }

    -- <c-k> is my expansion key
    -- this will expand the current item or jump to the next item within the snippet.
    vim.keymap.set({ "i", "s" }, "<c-k>", function()
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { silent = true })

    -- <c-j> is my jump backwards key.
    -- this always moves to the previous item within the snippet
    vim.keymap.set({ "i", "s" }, "<c-j>", function()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { silent = true })

    -- <c-l> is selecting within a list of options.
    -- This is useful for choice nodes (introduced in the forthcoming episode 2)
    vim.keymap.set("i", "<c-l>", function()
      if luasnip.choice_active() then
        luasnip.change_choice(1)
      end
    end)

    require("luasnip/loaders/from_vscode").lazy_load {
      paths = { "~/Documents/github/personal/dotfiles/snippets" },
    }
    -- require("luasnip.loaders.from_vscode").lazy_load()
    luasnip.filetype_extend("dart", { "flutter" })
  end,
}
