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

nnoremap <c-p> :GitFiles<cr>
