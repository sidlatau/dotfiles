return {
  "rcarriga/nvim-dap-ui",
  requires = { "mfussenegger/nvim-dap" },
  keys = {
    {
      "<leader>du",
      function()
        require("dapui").toggle()
      end,
      desc = "Toggle DAP UI",
    },
  },
  config = function()
    local dap, dapui = require "dap", require "dapui"
    dapui.setup()
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
  end,
}
