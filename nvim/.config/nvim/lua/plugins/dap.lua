return {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  config = function()
    vim.fn.sign_define(
      "DapBreakpoint",
      { text = "🟥", texthl = "", linehl = "", numhl = "" }
    )
    vim.fn.sign_define(
      "DapStopped",
      { text = "▶️", texthl = "", linehl = "", numhl = "" }
    )
    vim.keymap.set("n", "<F5>", function()
      require("dap").continue()
    end)
    vim.keymap.set("n", "<F10>", function()
      require("dap").step_over {}
    end)
    vim.keymap.set("n", "<F11>", function()
      require("dap").step_into {}
    end)
    vim.keymap.set("n", "<F12>", function()
      require("dap").step_out {}
    end)
  end,
}
