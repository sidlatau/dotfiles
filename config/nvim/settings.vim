set title
set titlestring=%t
" Colors
" ---------------------------------------------------------------------------
syntax enable
set background=dark
colorscheme gruvbox-material
let g:gruvbox_material_diagnostic_line_highlight = 1
let g:airline_theme = 'gruvbox_material'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 2
" ---------------------------------------------------------------------------


" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright
" reload files changed outside of Vim not currently modified in Vim (needs below)
set autoread
" http://stackoverflow.com/questions/2490227/how-does-vims-autoread-work#20418591
au FocusGained,BufEnter * :silent! !

set encoding=utf-8
set noerrorbells    
set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup      " don't create `filename~` backups
set autowrite     " Automatically :write before running commands
set noswapfile    " don't create temp files 
set undodir=~/.vim/undodir
set undofile


" http://vim.wikia.com/wiki/Searching
set nohlsearch incsearch ignorecase smartcase

" line numbers and distances
set relativenumber 
set number 

" number of lines offset when jumping
set scrolloff=8

" Tab key enters 2 spaces
" To enter a TAB character when `expandtab` is in effect,
" CTRL-v-TAB
set expandtab tabstop=2 shiftwidth=2 softtabstop=2 

" Indent new line the same as the preceding line
set autoindent

set lazyredraw                      " redraw after executing macro

" highlight matching parens, braces, brackets, etc
set showmatch

" open new buffers without saving current modifications (buffer remains open)
set hidden

" Use system clipboard
" http://vim.wikia.com/wiki/Accessing_the_system_clipboard
set clipboard=unnamedplus

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" CursorLine - sometimes autocmds are not performant; turn off if so
" http://vim.wikia.com/wiki/Highlight_current_line
set cursorline
set mouse=a                     " enable mouse support
set updatetime=100              " when to execute CursorHold
set noshowmode                  " don't display insert/normal/visual mode, we have a status line for that
let g:NERDSpaceDelims = 1       " Add spaces after comment delimiters by default

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set signcolumn=yes

let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

let $FZF_DEFAULT_OPTS = '--reverse'
let mapleader=" "
