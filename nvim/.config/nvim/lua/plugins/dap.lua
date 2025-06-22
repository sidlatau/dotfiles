return {
  "mfussenegger/nvim-dap",
  dependencies = { "theHamsta/nvim-dap-virtual-text" },
  event = "VeryLazy",
  config = function()
    require("nvim-dap-virtual-text").setup {}
    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "red" })
    vim.fn.sign_define(
      "DapBreakpointCondition",
      { text = "", texthl = "blue" }
    )
    vim.fn.sign_define(
      "DapBreakpointRejected",
      { text = "", texthl = "orange" }
    )
    vim.fn.sign_define("DapStopped", { text = "󰁕", texthl = "green" })
    vim.fn.sign_define("DapStopped", {
      text = "",
      texthl = "debugBreakpoint",
      linehl = "debugPC",
      numhl = "",
    })
  end,
}
