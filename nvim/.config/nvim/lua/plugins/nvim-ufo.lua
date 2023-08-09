return {
  -- UFO folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require "statuscol.builtin"
          require("statuscol").setup {
            relculright = true,
            segments = {
              { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
              { text = { "%s" }, click = "v:lua.ScSa" },
              { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
            },
          }
        end,
      },
    },
    event = "BufReadPost",
    opts = function()
      local ft_map = { dart = "lsp" }
      require("ufo").setup {
        open_fold_hl_timeout = 0,
        preview = {
          win_config = { winhighlight = "Normal:Normal,FloatBorder:Normal" },
        },
        enable_get_fold_virt_text = true,
        close_fold_kinds = { "imports", "comment" },
        provider_selector = function(_, ft)
          return ft_map[ft] or { "treesitter", "indent" }
        end,
      }
    end,
    keys = {
      {
        "zR",
        function()
          require("ufo").openAllFolds()
        end,
        "open all folds",
      },
      {
        "zM",
        function()
          require("ufo").closeAllFolds()
        end,
        "close all folds",
      },
      {
        "zP",
        function()
          require("ufo").peekFoldedLinesUnderCursor()
        end,
        "preview fold",
      },
    },
  },
}
