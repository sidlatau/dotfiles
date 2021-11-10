" Plugins
call plug#begin()

Plug 'tpope/vim-surround'
Plug 'bkad/camelcasemotion'
Plug 'machakann/vim-highlightedyank'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'svermeulen/vim-easyclip'

if !exists('g:vscode')
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
  Plug 'tpope/vim-obsession'
  Plug 'jiangmiao/auto-pairs'
  Plug 'mhinz/vim-startify'
  Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
  Plug 'tpope/vim-dispatch'
  Plug 'vim-test/vim-test'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'kdheepak/lazygit.nvim'
  Plug 'kyazdani42/nvim-web-devicons' " for file icons
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'folke/which-key.nvim'
  Plug 'akinsho/flutter-tools.nvim'
endif

call plug#end()

if !exists('g:vscode')
  source ~/.config/nvim/settings.vim
  source ~/.config/nvim/mappings.vim

lua << EOF
  require("which-key").setup { }
  require("flutter-tools").setup{
   fvm = true,
  }
  require'nvim-tree'.setup() -- use defaults
EOF
endif

map <Space> <Leader>

:set timeout timeoutlen=1000 ttimeoutlen=100
let g:camelcasemotion_key = '<leader>'
let g:highlightedyank_highlight_duration = 400
g:EasyClipUseSubstituteDefaults = true

if exists('g:vscode')
  nnoremap <leader>t <Cmd>call VSCodeNotify('dart.goToTestOrImplementationFile')<CR>
  nnoremap <leader>r <Cmd>call VSCodeNotify('dart.debugTestAtCursor')<CR>
  nnoremap <leader>fr <Cmd>call VSCodeNotify('flutter.hotRestart')<CR>
  nnoremap gr <Cmd>call VSCodeNotify('references-view.findReferences')<CR>
endif

"TODO: maybe use https://github.com/nvim-treesitter/nvim-treesitter-textobjects

