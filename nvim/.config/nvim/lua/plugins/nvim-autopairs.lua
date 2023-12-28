return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    local autopairs = require "nvim-autopairs"
    local cmp_autopairs = require "nvim-autopairs.completion.cmp"
    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
    autopairs.setup {
      close_triple_quotes = true,
      disable_filetype = { "neo-tree-popup" },
      check_ts = true,
      ts_config = {
        lua = { "string" },
        dart = { "string" },
        javascript = { "template_string" },
      },
    }
  end,
}
