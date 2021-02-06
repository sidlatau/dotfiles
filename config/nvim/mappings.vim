" ---------------------------------------------------------------------------

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" NERDTree
map <C-n> :NERDTreeToggle<CR>
" Clear highlighting on escape in normal mode
" nnoremap <esc> :noh<return><esc>

nmap <C-_> <Plug>NERDCommenterToggle " Ctrl+/ will toggle comment

fun! FzfOmniFiles()
  let is_git = system('git status')
  if v:shell_error
    :Files
  else
    :GitFiles
  endif
endfun

" FZF mapping
nnoremap <C-p> :call FzfOmniFiles()<CR>
nnoremap <c-b> :Buffers<cr>
