return {
  "github/copilot.vim",
  event = "VeryLazy",
  config = function()
    local function accept_word()
      vim.fn["copilot#Accept"] ""
      local bar = vim.fn["copilot#TextQueuedForInsertion"]()
      return vim.fn.split(bar, [[[ .]\zs]])[1]
    end

    local function accept_line()
      vim.fn["copilot#Accept"] ""
      local bar = vim.fn["copilot#TextQueuedForInsertion"]()
      return vim.fn.split(bar, [[[\n]\zs]])[1]
    end

    vim.g.copilot_filetypes = {
      ["*"] = true,
      gitcommit = true,
      DressingInput = false,
      TelescopePrompt = false,
      ["neo-tree-popup"] = false,
      ["dap-repl"] = false,
    }
    vim.keymap.set(
      "i",
      "<C-/>",
      "<Cmd>vertical Copilot panel<CR>",
      { desc = "open copilot panel" }
    )

    vim.keymap.set(
      "i",
      "<M-w>",
      accept_word,
      { expr = true, remap = false, desc = "accept word" }
    )
    vim.keymap.set(
      "i",
      "<M-l>",
      accept_line,
      { expr = true, remap = false, desc = "accept line" }
    )
  end,
}
