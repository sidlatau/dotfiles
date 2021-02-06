" Plugins
call plug#begin()

Plug 'tpope/vim-surround'
Plug 'bkad/camelcasemotion'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'machakann/vim-highlightedyank'
Plug 'tpope/vim-unimpaired'

if !exists('g:vscode')
  Plug 'dart-lang/dart-vim-plugin'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'sainnhe/gruvbox-material'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'preservim/nerdtree'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'preservim/nerdcommenter'
  Plug 'natebosch/vim-lsc'
  Plug 'natebosch/vim-lsc-dart'

endif

call plug#end()

if !exists('g:vscode')
  source ~/.config/nvim/settings.vim
  source ~/.config/nvim/mappings.vim
  source ~/.config/nvim/coc.vim
endif


:set timeout timeoutlen=3000 ttimeoutlen=100
let g:camelcasemotion_key = '<leader>'
let g:highlightedyank_highlight_duration = 400

if exists('g:vscode')
  nnoremap <leader>o <Cmd>call VSCodeNotify('dart-import.fix')<CR>
  nnoremap <leader>t <Cmd>call VSCodeNotify('dart.goToTestOrImplementationFile')<CR>
  nnoremap <leader>r <Cmd>call VSCodeNotify('dart.debugTestAtCursor')<CR>
endif

" https://github.com/nvim-treesitter/nvim-treesitter-textobjects
lua <<EOF
require'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
  },
}
EOF

