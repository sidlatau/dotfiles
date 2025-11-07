---@param picker snacks.Picker
local function explorer_add_in_parent(picker)
  local Tree = require "snacks.explorer.tree"
  local uv = vim.uv or vim.loop
  local default_dir = ""
  local parent = picker:current().parent
  if parent.dir == false then
    default_dir = picker:cwd()
  else
    default_dir = parent.file
  end
  Snacks.input({
    prompt = 'Add a new file or directory (directories end with a "/")',
    default = default_dir .. "/",
  }, function(value)
    if not value or value:find "^%s$" then
      return
    end
    local path = vim.fs.normalize(value)
    local is_file = value:sub(-1) ~= "/"
    local dir = is_file and vim.fs.dirname(path) or path
    if is_file and uv.fs_stat(path) then
      Snacks.notify.warn("File already exists:\n- `" .. path .. "`")
      return
    end
    vim.fn.mkdir(dir, "p")
    if is_file then
      io.open(path, "w"):close()
    end
    Tree:open(dir)
    Tree:refresh(dir)
    picker.update(picker, { target = path })
  end)
end

---@param picker snacks.Picker
local function copy_path_relative(picker)
  local selected = picker:selected({ fallback = true })[1]
  if not selected or selected == nil then
    return
  end
  vim.schedule(function()
    local cwd = picker:cwd()
    local relative_path =
      vim.fn.fnamemodify(selected.file, ":p"):gsub(cwd .. "/", "")
    vim.fn.setreg(vim.v.register, relative_path)
    vim.notify(
      relative_path,
      vim.log.levels.INFO,
      { title = "Relative Path Copied" }
    )
  end)
end

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = false },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    explorer = {},
    input = { enabled = true },
    picker = {
      sources = {
        gh_issue = {},
        gh_pr = {},
        explorer = {
          hidden = true,
          actions = {
            explorer_add_in_parent = explorer_add_in_parent,
            copy_path_relative = copy_path_relative,
          },
          win = {
            list = {
              keys = {
                ["A"] = { "explorer_add_in_parent" },
                ["Y"] = { "copy_path_relative" },
              },
            },
          },
          layout = {
            layout = {
              width = 60,
              min_width = 60,
              height = 0,
              position = "float",
              border = "rounded",
              box = "vertical",
              {
                win = "input",
                height = 1,
                border = "rounded",
                title = "{title} {live} {flags}",
                title_pos = "center",
              },
              { win = "list", border = "none" },
              {
                win = "preview",
                title = "{preview}",
                height = 0.4,
                border = "top",
              },
            },
          },
          auto_close = true,
          jump = { close = true },
        },
      },
    },
    quickfile = { enabled = true },
    words = {},
    scroll = {
      animate = {
        duration = { step = 15, total = 50 },
        easing = "inOutQuart",
      },
    },
    styles = {
      notification = {
        wo = { wrap = true }, -- Wrap notifications
        reverse = true,
        relative = "editor",
      },
      lazygit = {
        width = 0,
        height = 0,
        relative = "editor",
      },
    },
  },
  keys = {
    {
      "<leader>un",
      function()
        Snacks.notifier.hide()
      end,
      desc = "Dismiss All Notifications",
    },
    {
      "<leader>c",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete Buffer",
    },
    {
      "<leader>C",
      function()
        Snacks.bufdelete.other()
        vim.print "Deleted other buffers"
      end,
      desc = "Leave single Buffer",
    },
    {
      "<leader>gg",
      function()
        Snacks.lazygit()
      end,
      desc = "Lazygit",
    },
    {
      "<leader>nh",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "Notification History",
    },
    {
      "<leader>N",
      desc = "Neovim News",
      function()
        Snacks.win {
          file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
          width = 0.6,
          height = 0.6,
          wo = {
            spell = false,
            wrap = false,
            signcolumn = "yes",
            statuscolumn = " ",
            conceallevel = 3,
          },
        }
      end,
    },
    {
      "<leader>.",
      function()
        Snacks.scratch()
      end,
      desc = "Toggle Scratch Buffer",
    },
    {
      "<leader>S",
      function()
        Snacks.scratch.select()
      end,
      desc = "Select Scratch Buffer",
    },
    {
      "<leader>z",
      function()
        Snacks.zen()
      end,
      desc = "Toggle Zen Mode",
    },
    {
      "<leader>Z",
      function()
        Snacks.zen.zoom()
      end,
      desc = "Toggle Zoom",
    },
    {
      "<leader>gl",
      function()
        Snacks.lazygit.log_file()
      end,
      desc = "Lazygit Current File History",
    },
    {
      "<leader>gi",
      function()
        Snacks.picker.gh_issue()
      end,
      desc = "GitHub Issues (open)",
    },
    {
      "<leader>gI",
      function()
        Snacks.picker.gh_issue { state = "all" }
      end,
      desc = "GitHub Issues (all)",
    },
    {
      "<leader>gp",
      function()
        Snacks.picker.gh_pr()
      end,
      desc = "GitHub Pull Requests (open)",
    },
    {
      "<leader>gP",
      function()
        Snacks.picker.gh_pr { state = "all" }
      end,
      desc = "GitHub Pull Requests (all)",
    },
  },
}
