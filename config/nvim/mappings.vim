" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

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
nnoremap <silent><C-p> :call FzfOmniFiles()<CR>
nnoremap <leader>p :call FzfOmniFiles()<CR>
nnoremap <c-b> :Buffers<cr>

" Exit terminal mode 
tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"

" Save shortcut
nnoremap <c-s> :update<cr>
vnoremap <C-S> <C-C>:update<CR>
inoremap <c-s> <c-o>:update<cr>

if bufwinnr(1)
  nmap + <C-W>>
  nmap - <C-W><
endif

" Debugger remaps
nnoremap <leader>de :call vimspector#Reset()<CR>
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'

" Fugitive
nnoremap <Leader>gs :Gstatus<cr>

nnoremap <silent> <Leader>s :Rg<CR>
