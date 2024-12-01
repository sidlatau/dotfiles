local function telescope_image_preview()
  local supported_images =
    { "svg", "png", "jpg", "jpeg", "gif", "webp", "avif" }
  local from_entry = require "telescope.from_entry"
  local Path = require "plenary.path"
  local conf = require("telescope.config").values
  local Previewers = require "telescope.previewers"

  local previewers = require "telescope.previewers"
  local image_api = require "image"

  local is_image_preview = false
  local image = nil
  local last_file_path = ""

  local is_supported_image = function(filepath)
    local split_path = vim.split(filepath:lower(), ".", { plain = true })
    local extension = split_path[#split_path]
    return vim.tbl_contains(supported_images, extension)
  end

  local delete_image = function()
    if not image then
      return
    end

    image:clear()

    is_image_preview = false
  end

  local create_image = function(filepath, winid, bufnr)
    image = image_api.hijack_buffer(filepath, winid, bufnr)

    if not image then
      return
    end

    vim.schedule(function()
      image:render()
    end)

    is_image_preview = true
  end

  local function defaulter(f, default_opts)
    default_opts = default_opts or {}
    return {
      new = function(opts)
        if conf.preview == false and not opts.preview then
          return false
        end
        opts.preview = type(opts.preview) ~= "table" and {} or opts.preview
        if type(conf.preview) == "table" then
          for k, v in pairs(conf.preview) do
            opts.preview[k] = vim.F.if_nil(opts.preview[k], v)
          end
        end
        return f(opts)
      end,
      __call = function()
        local ok, err = pcall(f(default_opts))
        if not ok then
          error(debug.traceback(err))
        end
      end,
    }
  end

  -- NOTE: Add teardown to cat previewer to clear image when close Telescope
  local file_previewer = defaulter(function(opts)
    opts = opts or {}
    local cwd = opts.cwd or vim.loop.cwd()
    return Previewers.new_buffer_previewer {
      title = "File Preview",
      dyn_title = function(_, entry)
        return Path:new(from_entry.path(entry, true)):normalize(cwd)
      end,

      get_buffer_by_name = function(_, entry)
        return from_entry.path(entry, true)
      end,

      define_preview = function(self, entry, _)
        local p = from_entry.path(entry, true)
        if p == nil or p == "" then
          return
        end

        conf.buffer_previewer_maker(p, self.state.bufnr, {
          bufname = self.state.bufname,
          winid = self.state.winid,
          preview = opts.preview,
        })
      end,

      teardown = function(_)
        if is_image_preview then
          delete_image()
        end
      end,
    }
  end, {})

  local buffer_previewer_maker = function(filepath, bufnr, opts)
    -- NOTE: Clear image when preview other file
    if is_image_preview and last_file_path ~= filepath then
      delete_image()
    end

    last_file_path = filepath

    if is_supported_image(filepath) then
      create_image(filepath, opts.winid, bufnr)
    else
      previewers.buffer_previewer_maker(filepath, bufnr, opts)
    end
  end

  return {
    buffer_previewer_maker = buffer_previewer_maker,
    file_previewer = file_previewer.new,
  }
end

return {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  config = function()
    local yank_selected_entry = function(prompt_bufnr)
      local action_state = require "telescope.actions.state"
      local entry_display = require "telescope.pickers.entry_display"
      local actions = require "telescope.actions"

      local picker = action_state.get_current_picker(prompt_bufnr)
      local manager = picker.manager

      local selection_row = picker:get_selection_row()
      local entry = manager:get_entry(picker:get_index(selection_row))
      local display, _ = entry_display.resolve(picker, entry)

      actions.close(prompt_bufnr)

      vim.fn.setreg("+", display)
    end

    local telescope = require "telescope"
    local telescopeConfig = require "telescope.config"
    -- Register filetypes via plenary for telescope previewers
    -- https://github.com/nvim-lua/plenary.nvim#plenaryfiletype
    require("plenary.filetype").add_file "filetypes"

    -- Clone the default Telescope configuration
    local vimgrep_arguments =
      { unpack(telescopeConfig.values.vimgrep_arguments) }

    -- I want to search in hidden/dot files.
    table.insert(vimgrep_arguments, "--hidden")
    -- I don't want to search in the `.git` directory.
    table.insert(vimgrep_arguments, "--glob")
    table.insert(vimgrep_arguments, "!**/.git/*")
    local image_preview = telescope_image_preview()

    telescope.setup {
      defaults = {
        mappings = {
          i = {
            ["<C-k"] = require("telescope.actions").cycle_history_next,
            ["<C-j>"] = require("telescope.actions").cycle_history_prev,
            ["<c-y>"] = yank_selected_entry,
          },
          n = {
            ["<c-y>"] = yank_selected_entry,
          },
        },
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },
        file_ignore_patterns = { "%.g.dart", "%.freezed.dart" },
        -- `hidden = true` is not supported in text grep commands.
        vimgrep_arguments = vimgrep_arguments,
        file_previewer = image_preview.file_previewer,
        buffer_previewer_maker = image_preview.buffer_previewer_maker,
      },
      pickers = {
        find_files = {
          find_command = {
            "fd",
            "--type",
            "file",
            "--type",
            "symlink",
            "--hidden",
            "--exclude",
            ".git",
            -- put your other patterns here
          },
        },
      },
      extensions = {
        recent_files = {
          only_cwd = true,
        },
        advanced_git_search = {},
      },
    }

    require("telescope").load_extension "dap"
    require("telescope").load_extension "fzf"
    require("telescope").load_extension "recent_files"
    require("telescope").load_extension "advanced_git_search"
  end,
  keys = {
    {
      "<leader>R",
      "<cmd>Telescope resume<cr>",
      desc = "Telescope resume",
    },
    {
      "<leader>oh",
      "<cmd>Telescope help_tags<CR>",
      desc = "Help tags",
    },
    {
      "<leader>ot",
      "<cmd>Telescope colorscheme<CR>",
      desc = "Color Scheme",
    },
    {
      "<leader>ok",
      "<cmd>Telescope keymaps<CR>",
      desc = "Keymaps",
    },
    {
      "<leader>oo",
      require("telescope").extensions.recent_files.pick,
      desc = "Recent files",
    },
  },
}
