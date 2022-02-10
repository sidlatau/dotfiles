local M = {}
--- Create autocommand groups based on the passed definitions
---@param definitions table contains trigger, pattern and text. The key will be used as a group name
---@param buffer boolean indicate if the augroup should be local to the buffer
function M.define_augroups(definitions, buffer)
  for group_name, definition in pairs(definitions) do
    vim.cmd("augroup " .. group_name)
    if buffer then
      vim.cmd [[autocmd! * <buffer>]]
    else
      vim.cmd [[autocmd!]]
    end

    for _, def in pairs(definition) do
      local command = table.concat(vim.tbl_flatten { "autocmd", def }, " ")
      vim.cmd(command)
    end

    vim.cmd "augroup END"
  end
end

--- Disable autocommand groups if it exists
--- This is more reliable than trying to delete the augroup itself
---@param name string the augroup name
function M.disable_augroup(name)
  -- defer the function in case the autocommand is still in-use
  vim.schedule(function()
    if vim.fn.exists("#" .. name) == 1 then
      vim.cmd("augroup " .. name)
      vim.cmd "autocmd!"
      vim.cmd "augroup END"
    end
  end)
end

function M.enable_format_on_save(opts)
  local fmd_cmd = string.format("LspFormat", opts.timeout)
  M.define_augroups {
    format_on_save = { { "BufWritePre", opts.pattern, fmd_cmd } },
  }
end

function M.enable_fix_all_on_save()
  local fmd_cmd = ":LspFixAll"

  M.define_augroups {
    fix_all_on_save = { { "BufWritePre", "*.dart", fmd_cmd } },
  }
end

function M.disable_format_on_save()
  M.disable_augroup "format_on_save"
end

M.enable_format_on_save { pattern = "*", timeout = 200 }
M.enable_fix_all_on_save()

vim.cmd [[
command LspFormat :silent lua vim.lsp.buf.formatting_sync()
command LspFixAll :silent lua require('user.lsp.handlers').code_action_fix_all()
]]

vim.cmd [[
  augroup _general_settings
    autocmd!
    " Simplify exit
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 

    " Set comment string for dart as //  
    autocmd FileType dart setlocal commentstring=//\ %s

    " Treat arb files as json
    autocmd BufRead *.arb :set filetype=json
  augroup end
]]

vim.cmd [[
  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal spell
  augroup end
]]
