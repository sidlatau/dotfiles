return {
  "j-hui/fidget.nvim",
  config = function()
    require("fidget").setup {
      text = {
        spinner = "moon",
      },
      timer = {
        spinner_rate = 125, -- frame rate of spinner animation, in ms
        fidget_decay = 1000, -- how long to keep around empty fidget, in ms
        task_decay = 500, -- how long to keep around completed task, in ms
      },
    }
  end,
}
