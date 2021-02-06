
" Colors
" ---------------------------------------------------------------------------
syntax enable
set background=dark
colorscheme gruvbox-material
let g:gruvbox_material_diagnostic_line_highlight = 1
let g:airline_theme = 'gruvbox_material'
" ---------------------------------------------------------------------------


" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright
" reload files changed outside of Vim not currently modified in Vim (needs below)
set autoread
" http://stackoverflow.com/questions/2490227/how-does-vims-autoread-work#20418591
au FocusGained,BufEnter * :silent! !

set encoding=utf-8
set visualbell    " errors flash screen rather than emit beep
set backspace=2   " Backspace deletes like most programs in insert mode
set showcmd       " display incomplete commands
set modelines=0   " Disable modelines as a security precaution
set nobackup      " don't create `filename~` backups
set autowrite     " Automatically :write before running commands
set noswapfile    " don't create temp files 

" line numbers and distances
set relativenumber 
set number 
set numberwidth=5

" number of lines offset when jumping
set scrolloff=2

" Tab key enters 2 spaces
" To enter a TAB character when `expandtab` is in effect,
" CTRL-v-TAB
set expandtab tabstop=2 shiftwidth=2 softtabstop=2 

" Indent new line the same as the preceding line
set autoindent

" make scrolling and painting fast
" ttyfast kept for vim compatibility but not needed for nvim
set ttyfast lazyredraw

" highlight matching parens, braces, brackets, etc
set showmatch

" http://vim.wikia.com/wiki/Searching
set hlsearch incsearch ignorecase smartcase

" As opposed to `wrap`
"set nowrap

" http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
set autochdir

" open new buffers without saving current modifications (buffer remains open)
set hidden

" http://stackoverflow.com/questions/9511253/how-to-effectively-use-vim-wildmenu
set wildmenu wildmode=list:longest,full

set laststatus=2              " StatusLine always visible

" Use system clipboard
" http://vim.wikia.com/wiki/Accessing_the_system_clipboard
set clipboard=unnamedplus

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" CursorLine - sometimes autocmds are not performant; turn off if so
" http://vim.wikia.com/wiki/Highlight_current_line
set cursorline
" Normal mode
highlight CursorLine ctermbg=None
" autocmd InsertEnter * highlight  CursorLine ctermbg=17 ctermfg=None
" autocmd InsertLeave * highlight  CursorLine ctermbg=None ctermfg=None  
set mouse=a                     " enable mouse support
set updatetime=100              " when to execute CursorHold
set noshowmode                  " don't display insert/normal/visual mode, we have a status line for that
let g:NERDSpaceDelims = 1       " Add spaces after comment delimiters by default

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set signcolumn=number


