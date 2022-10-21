vim.cmd [[
setlocal fo+=r " Automatically insert comment string after hitting ENTER in insert mode

setlocal isfname+=:
setlocal iskeyword+=$
]]
vim.opt_local.spell = true
vim.opt_local.spelloptions:append { "camel", "noplainbuffer" }
