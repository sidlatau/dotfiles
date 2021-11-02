" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

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
nnoremap <leader>p :FZFMru<cr>
let g:fzf_mru_relative = 1
nnoremap <c-b> :Buffers<cr>

" stsewd/fzf-checkout.vim 
nnoremap <leader>gb :GBranches<cr>

" Exit terminal mode 
tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"

" Save shortcut
nnoremap <c-s> :write<cr>
vnoremap <C-S> <C-C>:write<CR>
inoremap <c-s> <c-o>:write<cr><esc>

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

" Close window
nnoremap <leader>qq :Sayonara!<cr>

" vim-test
nmap <silent><leader>tn :TestNearest<CR>
nmap <silent><leader>tf :TestFile<CR>
nmap <silent><leader>ts :TestSuite<CR>
nmap <silent><leader>tl :TestLast<CR>
nmap <silent><leader>tv :TestVisit<CR>

" Search current word
nnoremap <silent><Leader>fw :Rg <C-R><C-W><CR>

" Telescope mappings
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" setup mapping to call :LazyGit
nnoremap <silent> <leader>gg :LazyGit<CR>
