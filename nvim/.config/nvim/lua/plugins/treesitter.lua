return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufRead" },
  config = function()
    local configs = require "nvim-treesitter.configs"
    configs.setup {
      ensure_installed = {
        "lua",
        "dart",
        "go",
        "tsx",
        "html",
        "typescript",
        "javascript",
        "vim",
        "bash",
        "markdown",
        "markdown_inline",
        "regex",
        "c_sharp",
        "kotlin",
        "python",
        "sql",
        "diff",
      },
      modules = {},
      auto_install = true,
      sync_install = true,
      ignore_install = { "" }, -- List of parsers to ignore installing
      highlight = {
        enable = true,
      },
      textobjects = {
        select = {
          enable = true,

          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,

          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["ip"] = "@parameter.outer",
            ["ap"] = "@parameter.inner",
          },
          include_surrounding_whitespace = true,
        },
      },
    }
    vim.g.skip_ts_context_commentstring_module = true
    require("ts_context_commentstring").setup {
      enable_autocmd = false,
    }
  end,
}
