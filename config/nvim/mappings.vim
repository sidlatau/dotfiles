" ---------------------------------------------------------------------------

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" NERDTree
map <C-n> :NERDTreeToggle<CR>
" Clear highlighting on escape in normal mode
nnoremap <esc> :noh<return><esc>

nmap <C-_> <Plug>NERDCommenterToggle " Ctrl+/ will toggle comment

"-------------------------------------------
imap <tab> <Plug>(completion_smart_tab)
imap <s-tab> <Plug>(completion_smart_s_tab)
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
"-------------------------------------------
"Telescope
" Find files using Telescope command-line sugar.
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <C-b> <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
"-------------------------------------------
