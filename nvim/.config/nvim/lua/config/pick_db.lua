local Job = require "plenary.job"
local M = {}
local MENU_PADDING = 4
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"
local entry_display = require "telescope.pickers.entry_display"
local themes = require "telescope.themes"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local function to_selection_entries(app_identifiers)
  if not app_identifiers or #app_identifiers < 1 then
    return {}
  end
  return vim.tbl_map(function(app_identifier)
    return {
      text = app_identifier,
      data = app_identifier,
    }
  end, app_identifiers)
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

local function command_entry_maker()
  local make_display = function(en)
    local displayer = entry_display.create {
      separator = en.hint ~= "" and " • " or "",
      items = {
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

local function picker_opts(items, opts)
  local callback = opts.callback or execute_command
  return {
    prompt_title = opts.title,
    finder = finders.new_table {
      results = items,
      entry_maker = command_entry_maker(),
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
        id = item.text,
        label = item.text,
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
    kind = "dart_db",
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

local function to_dbs(db_path_content)
  if not db_path_content or #db_path_content < 1 then
    return {}
  end
  return vim.tbl_map(function(db_path)
    local name = vim.api.nvim_call_function("fnamemodify", { db_path, ":t" })
    return {
      name = name,
      url = "sqlite:" .. db_path,
    }
  end, db_path_content)
end

local function set_database_paths(result)
  local path = result[1]
  local db_path = path .. "/Documents/databases"
  local db_path_content =
    vim.split(vim.fn.glob(db_path .. "/*"), "\n", { trimempty = true })
  local new_dbs = to_dbs(db_path_content)
  -- Merge new databases with existing ones
  vim.g.dbs = vim.tbl_extend("force", vim.g.dbs or {}, new_dbs)
end

local function build_database_connection(app_identifier)
  if not app_identifier then
    return M.notify "Sorry no app identifier found"
  end
  local job = Job:new {
    command = "xcrun",
    args = { "simctl", "get_app_container", "booted", app_identifier, "data" },
  }
  job:after_success(vim.schedule_wrap(function(j)
    set_database_paths(j:result())
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

local function show_app_identifier_picker(result)
  local lines = to_selection_entries(result)
  if #lines > 0 then
    select {
      title = "App identifiers",
      lines = lines,
      on_select = build_database_connection,
    }
  end
end

function M.open_simulator_db_connection()
  local app_identifiers =
    { "com.mworker.mw", "com.devinco.mobileworker", "com.devinco.speedycraft" }

  show_app_identifier_picker(app_identifiers)
end

return M
