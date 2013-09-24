
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'kien/ctrlp.vim.git'
Bundle 'jnwhiteh/vim-golang'
Bundle 'othree/html5.vim'
Bundle 'msanders/snipmate.vim'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdcommenter'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'derekwyatt/vim-scala'

filetype plugin indent on     " required!


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
set shiftwidth=2
set softtabstop=2

" Options
set list listchars=tab:▷⋅,trail:⋅       " display extra whitespaces
set ruler       " show the cursor position all the time
set showcmd     " display incomplete commands
set incsearch   " do incremental searching
set hlsearch    " highlight search result
set visualbell  " no beep when press Esc in normal mode
set hidden      " to switch buffer without unsaved warning

" Key mappings
let mapleader = " "                             " use <space> as <Leader>
" previous/next buffer
nnoremap <silent> J :bp<CR>
nnoremap <silent> K :bn<CR>
" clear search pattern
nnoremap <silent> <Leader><BS> :let@/=""<CR>
" completion
inoremap <c-l> <c-X><c-L>
inoremap <c-t> <c-X><c-F>
inoremap <c-o> <c-X><c-O>
" typos
cnoremap q1 q!
" toggle line number
map <silent> <F2> :set number!<CR>
" toggle paste mode
map <F3>          :set invpaste<CR>


" For CtrlP
let g:ctrlp_show_hidden = 0
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](node_modules|bower_components|dev/gae|dev/android)$'
  \,'file': '\v\.(swp|jar|png|jpg|gif|tgz|gz|pdf)$'
  \ }


" For Python
au FileType py set autoindent
au FileType py set smartindent
au FileType py set shiftwidth=4
au FileType py set softtabstop=4
au FileType py set textwidth=79 " PEP-8 Friendly


" For Go
au FileType go set noexpandtab
au FileType go set tabstop=2
au FileType go set list listchars=tab:\ \ ,trail:·    " display extra whitespaces


" Functions
