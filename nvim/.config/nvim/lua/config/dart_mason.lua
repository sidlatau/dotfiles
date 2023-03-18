local Job = require "plenary.job"
local M = {}
local MENU_PADDING = 4
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"
local entry_display = require "telescope.pickers.entry_display"
local themes = require "telescope.themes"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

function M.join(lines)
  return table.concat(lines, "\n")
end

M.notify = function(msg, level, opts)
  opts = opts or {}
  level = level or M.INFO
  msg = type(msg) == "table" and M.join(msg) or msg
  if msg == "" then
    return
  end
  vim.notify(msg, level, {
    title = "Dart Mason",
    timeout = opts.timeout,
    icon = "",
  })
end

local function parse(line)
  local parts = vim.split(line, " --> ")
  if #parts == 2 then
    local brick_parts = vim.split(parts[1], " ")
    if #brick_parts == 3 then
      return {
        name = vim.trim(brick_parts[2]),
        version = vim.trim(brick_parts[3]),
      }
    end
  end
end

local function get_bricks(result)
  local bricks = {}
  for _, line in pairs(result) do
    local brick = parse(line)
    if brick then
      table.insert(bricks, brick)
    end
  end
  return bricks
end

local function to_selection_entries(result)
  if not result or #result < 1 then
    return {}
  end
  local bricks = get_bricks(result)
  return vim.tbl_map(function(brick)
    return {
      text = string.format(" %s %s ", brick.name, " • " .. brick.version),
      data = brick,
    }
  end, bricks)
end

local function command_entry_maker(max_width)
  local make_display = function(en)
    local displayer = entry_display.create {
      separator = en.hint ~= "" and " • " or "",
      items = {
        { width = max_width },
        { remaining = true },
      },
    }

    return displayer {
      { en.label, "Type" },
      { en.hint, "Comment" },
    }
  end
  return function(entry)
    return {
      ordinal = entry.id,
      command = entry.command,
      hint = entry.hint,
      label = entry.label,
      display = make_display,
    }
  end
end

local function get_max_length(commands)
  local max = 0
  for _, value in ipairs(commands) do
    max = #value.label > max and #value.label or max
  end
  return max
end

local function execute_command(bufnr)
  local selection = action_state.get_selected_entry()
  actions.close(bufnr)
  local cmd = selection.command
  if cmd then
    local success, msg = pcall(cmd)
    if not success then
      vim.notify(msg, vim.log.levels.ERROR)
    end
  end
end

local function picker_opts(items, opts)
  local callback = opts.callback or execute_command
  return {
    prompt_title = opts.title,
    finder = finders.new_table {
      results = items,
      entry_maker = command_entry_maker(get_max_length(items)),
    },
    sorter = sorters.get_generic_fuzzy_sorter(),
    attach_mappings = function(_, map)
      map("i", "<CR>", callback)
      map("n", "<CR>", callback)
      -- If the return value of `attach_mappings` is true, then the other
      -- default mappings are still applies.
      -- Return false if you dont want any other mappings applied.
      -- A return value _must_ be returned. It is an error to not return anything.
      return true
    end,
  }
end

local function get_menu_config(items, user_opts, opts)
  opts = vim.tbl_deep_extend("keep", user_opts or {}, opts or {})
  return themes.get_dropdown(
    vim.tbl_deep_extend("keep", picker_opts(items, opts), {
      previewer = false,
      layout_config = { height = #items + MENU_PADDING },
    })
  )
end

local function get_telescope_picker_config(items, title, on_select)
  local ok = pcall(require, "telescope")
  if not ok then
    return
  end
  return get_menu_config(
    vim.tbl_map(function(item)
      local data = item.data
      return {
        id = data.name,
        label = data.name,
        hint = data.version,
        command = function()
          on_select(data)
        end,
      }
    end, items),
    { title = title }
  )
end

local function select(opts)
  assert(opts ~= nil, "An options table must be passed to popup create!")
  local title, lines, on_select = opts.title, opts.lines, opts.on_select
  if not lines or #lines < 1 then
    return
  end

  vim.ui.select(lines, {
    prompt = title,
    kind = "dart_mason",
    format_item = function(item)
      return item.text
    end,
    -- custom key for dressing.nvim
    telescope = get_telescope_picker_config(lines, title, on_select),
  }, function(item)
    if not item then
      return
    end
    on_select(item.data)
  end)
end

local function make_brick(brick, name, path)
  local job = Job:new {
    command = "mason",
    args = {
      "make",
      brick.name,
      "-q",
      "--name",
      name,
      "-o",
      path,
      "--on-conflict",
      "overwrite",
    },
  }
  job:after_success(vim.schedule_wrap(function(j)
    M.notify(M.join(j:result()))
  end))
  job:after_failure(vim.schedule_wrap(function(j)
    return M.notify(
      M.join(j:stderr_result()),
      vim.log.levels.ERROR,
      { timeout = 5000 }
    )
  end))
  job:start()
end

local function select_brick(brick)
  if not brick then
    return M.notify "Sorry there is no brick on this line"
  end

  if brick.name ~= "dna_screen" then
    return M.notify "Brick is not supported yet"
  end

  vim.ui.input({
    prompt = "Enter name:",
  }, function(name)
    if not name or #name == 0 then
      return
    end
    vim.ui.input({
      prompt = "Enter path:",
      default = "lib/",
      completion = "file",
    }, function(path)
      if not path or #name == 0 then
        return
      end
      make_brick(brick, name, path)
    end)
  end)
end

local function show_bricks(result)
  local lines = to_selection_entries(result)
  if #lines > 0 then
    select {
      title = "Bricks",
      lines = lines,
      on_select = select_brick,
    }
  end
end

function M.list_bricks()
  local job = Job:new { command = "mason", args = { "list" } }
  job:after_success(vim.schedule_wrap(function(j)
    show_bricks(j:result())
  end))
  job:after_failure(vim.schedule_wrap(function(j)
    return M.notify(
      M.join(j:stderr_result()),
      vim.log.levels.ERROR,
      { timeout = 5000 }
    )
  end))
  job:start()
end

return M
