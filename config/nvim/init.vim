" Plugins
call plug#begin()

Plug 'tpope/vim-surround'
Plug 'bkad/camelcasemotion'
Plug 'machakann/vim-highlightedyank'
Plug 'tpope/vim-unimpaired'

if !exists('g:vscode')
  Plug 'dart-lang/dart-vim-plugin'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'sainnhe/gruvbox-material'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'stsewd/fzf-checkout.vim'
  Plug 'pbogut/fzf-mru.vim'
  Plug 'preservim/nerdcommenter'
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'SirVer/ultisnips'
  Plug 'natebosch/dartlang-snippets'
  Plug 'ryanoasis/vim-devicons'
  Plug 'puremourning/vimspector'
  Plug 'szw/vim-maximizer'
  Plug 'tpope/vim-obsession'
  Plug 'jiangmiao/auto-pairs'
  Plug 'mhinz/vim-startify'
  Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
  Plug 'tpope/vim-dispatch'
  Plug 'vim-test/vim-test'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
endif

call plug#end()

if !exists('g:vscode')
  " dart-vim-plugin
  let dart_format_on_save = 1
  let dart_style_guide = 2

  source ~/.config/nvim/settings.vim
  source ~/.config/nvim/mappings.vim
  source ~/.config/nvim/coc.vim
endif


:set timeout timeoutlen=3000 ttimeoutlen=100
let g:camelcasemotion_key = '<leader>'
let g:highlightedyank_highlight_duration = 400

if exists('g:vscode')
  nnoremap <leader>t <Cmd>call VSCodeNotify('dart.goToTestOrImplementationFile')<CR>
  nnoremap <leader>r <Cmd>call VSCodeNotify('dart.debugTestAtCursor')<CR>
  nnoremap <leader>fr <Cmd>call VSCodeNotify('flutter.hotRestart')<CR>
endif

"TODO: maybe use https://github.com/nvim-treesitter/nvim-treesitter-textobjects

