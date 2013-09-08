" Pathogen
execute pathogen#infect()

" Line number
set number
set cursorline

" Syntax Highlighting
syntax enable
set background=dark
colorscheme solarized
set t_Co=256

" Indentation
filetype plugin indent on
set expandtab
set shiftwidth=4
set softtabstop=4

" Options
set list listchars=tab:▷⋅,trail:⋅       " display extra whitespaces
set ruler       " show the cursor position all the time
set showcmd     " display incomplete commands
set incsearch   " do incremental searching
set hlsearch    " highlight search result
set visualbell  " no beep when press Esc in normal mode
set hidden      " to switch buffer without unsaved warning

" Key mappings
nnoremap <silent> ,/ :let@/=""<CR>   " clear search pattern
cnoremap q1 q!                       " typo q1
map <silent> <F2> :set number!<CR>   " toggle line number
map <F3>          :set invpaste<CR>  " toggle paste mode


" For CtrlP
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](node_modules|bower_components|\.git|\.hg|\.svn)$'
  \ }


" For Python
au FileType py set autoindent
au FileType py set smartindent
au FileType py set textwidth=79 " PEP-8 Friendly


" For Go
au FileType go set noexpandtab
au FileType go set tabstop=2
au FileType go set list listchars=tab:\ \ ,trail:·    " display extra whitespaces


" Functions
