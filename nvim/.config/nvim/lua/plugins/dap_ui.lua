return {
  {
    "miroshQa/debugmaster.nvim",
    -- osv is needed if you want to debug neovim lua code. Also can be used
    -- as a way to quickly test-drive the plugin without configuring debug adapters
    dependencies = {
      "mfussenegger/nvim-dap",
      "jbyuki/one-small-step-for-vimkind",
    },
    config = function()
      local dm = require "debugmaster"
      dm.keys.get("q").key = "O"
      -- make sure you don't have any other keymaps that starts with "<leader>d" to avoid delay
      -- Alternative keybindings to "<leader>d" could be: "<leader>m", "<leader>;"
      vim.keymap.set(
        { "n", "v" },
        "<leader>d",
        dm.mode.toggle,
        { nowait = true }
      )
      vim.keymap.set("n", "<Esc>", function()
        dm.mode.disable()
      end)
      -- This might be unwanted if you already use Esc for ":noh"
      vim.keymap.set(
        "t",
        "<C-\\>",
        "<C-\\><C-n>",
        { desc = "Exit terminal mode" }
      )

      dm.plugins.osv_integration.enabled = true -- needed if you want to debug neovim lua code
    end,
  },
}
