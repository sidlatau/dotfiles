local configs = require "nvim-treesitter.configs"
configs.setup {
  ensure_installed = { "lua", "dart", "go" },
  sync_install = false,
  ignore_install = { "" }, -- List of parsers to ignore installing
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = false,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ip"] = "@parameter.outer",
        ["ap"] = "@parameter.inner",
      },
    },
  },
}
