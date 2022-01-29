vim.cmd [[
  nnoremap <leader>t <Cmd>call VSCodeNotify('dart.goToTestOrImplementationFile')<CR>
  nnoremap <leader>r <Cmd>call VSCodeNotify('dart.debugTestAtCursor')<CR>
  nnoremap <leader>fr <Cmd>call VSCodeNotify('flutter.hotRestart')<CR>
  nnoremap gr <Cmd>call VSCodeNotify('references-view.findReferences')<CR>
]]
