
set nocompatible               " be iMproved

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" UI enhancements
Plug 'https://github.com/ctrlpvim/ctrlp.vim.git'
Plug 'bling/vim-bufferline'
Plug 'bling/vim-airline'

" Checkers/Linters
Plug 'vim-syntastic/syntastic'

" Typing helpers
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'teerapap/vim-template'

" Shortcut helpers
Plug 'tpope/vim-unimpaired'

" Command helpers
Plug 'tpope/vim-fugitive'

" Syntax plugins
Plug 'fladson/vim-kitty'
Plug 'othree/html5.vim'
Plug 'chr4/nginx.vim'
Plug 'vim-scripts/haproxy'
" tabular is required by vim-markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'mechatroner/rainbow_csv'


" Initialize plugin system
call plug#end()


" Line number
set number
set cursorline

" Syntax Highlighting
syntax enable

" Indentation
filetype plugin indent on
set expandtab
set shiftwidth=4
set softtabstop=4

" Options
set listchars=tab:>-   " display extra whitespaces
set ruler       " show the cursor position all the time
set showcmd     " display incomplete commands
set incsearch   " do incremental searching
set hlsearch    " highlight search result
set hidden      " to switch buffer without unsaved warning
set laststatus=2      " always show status bar
set lazyredraw  " Improve scrolling speed
set cscopequickfix=s-,c-,d-,i-,t-,e-
set exrc        " enable per-directory .vimrc files
set secure      " disable unsafe commands in local .vimrc files

" Key mappings
let mapleader = " "                             " use <space> as <Leader>
" previous/next buffer
nnoremap <silent> J :bp<CR>
nnoremap <silent> K :bn<CR>
" window navigation
nnoremap <Leader>j <C-W>j
nnoremap <Leader>k <C-W>k
nnoremap <Leader>h <C-W>h
nnoremap <Leader>l <C-W>l
" clear search pattern
nnoremap <silent> <Leader><BS> :let@/=""<CR>
" completion
inoremap <c-l> <c-X><c-L>
inoremap <c-t> <c-X><c-F>
inoremap <c-o> <c-X><c-O>
" Toggle quickfix list
nmap <silent> <leader>q :call ToggleList("Quickfix List", 'c')<CR>
nmap <silent> > :cnext<CR>
nmap <silent> < :cprevious<CR>
" run make command
nnoremap <silent> <leader>m :make<CR>
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
  \,'file': '\v\.(swp|class|jar|png|jpg|gif|tgz|gz|pdf)$'
  \ }


" For vim-airline
let g:airline#extensions#bufferline#enabled = 0
let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n'  : 'N',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'c'  : 'C',
      \ 'v'  : 'V',
      \ 'V'  : 'V',
      \ '' : 'V',
      \ 's'  : 'S',
      \ 'S'  : 'S',
      \ '' : 'S',
      \ }

" For Syntastic
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': ['java','scala'] }
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_c_include_dirs = split($SYNTASTIC_C_INCLUDE,':')


" For vim-template
let g:user = "Teerapap Changwichukarn"
let g:email = "teerapap.c@gmail.com"

" For markdown
let g:vim_markdown_folding_disabled = 1

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


" Custom commands
com! DiffSaved call s:DiffWithSaved()

" Functions

function! GetBufferList()
  redir =>buflist
  silent! ls
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

function! s:DiffWithSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction

" include local vimrc
if filereadable($HOME.'/.vimrc.local')
  source $HOME/.vimrc.local
endif
" include vimrc in contrib
if filereadable('./contrib/vimrc')
  source ./contrib/vimrc
endif

