
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

" Golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

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
set splitbelow  " split new window on the below
set splitright  " split new window on the right

" autocomplete
set completeopt+=longest   " autocompletion only inserts the longest common text of all the matches
au CompleteDone * pclose   " autocompletion preview close after done

" Key mappings
let mapleader = " "                             " use <space> as <Leader>
" open/close buffer
nnoremap <Leader>o :edit 
nnoremap <Leader>n :enew<CR>
nnoremap <Leader>d :bdelete<CR>
" open terminal
nnoremap <Leader>t :terminal<CR>
" previous/next/delete buffer
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
imap <c-l> <c-X><c-L>
imap <c-f> <c-X><c-F>
imap <c-o> <c-X><c-O>

" Toggle Quickfix
nnoremap <silent> <expr> <Leader>q empty(filter(getwininfo(), 'v:val.quickfix')) ? ':copen<CR>' : ':cclose<CR>'
" Unlisted quickfix list
augroup qf
  autocmd!
  autocmd FileType qf set nobuflisted
augroup END

" run make command
nnoremap <silent> <Leader>m :make<CR>
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
au FileType go set shiftwidth=2
au FileType go set tabstop=2
au FileType go set list listchars=tab:\ \ ,trail:·    " display extra whitespaces
au FileType go set autowrite                          " save on build


" For vim-go
let g:go_template_autocreate = 0    " vim-template takes care of the new file template
let g:go_doc_keywordprg_enabled = 0  " disable K mapping conflict
au FileType go nmap <Leader>gr <Plug>(go-run)
au FileType go nmap <Leader>gb <Plug>(go-build)
au FileType go nmap <Leader>gt <Plug>(go-test)
au FileType go nmap <Leader>gc <Plug>(go-coverage-toggle)
au FileType go nmap <Leader>ga <Plug>(go-alternate-vertical)
au FileType go nmap <Leader>gd :GoDecls<CR>
au FileType go nmap <Leader>gk <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gi <Plug>(go-info)


" Custom commands
com! DiffSaved call s:DiffWithSaved()

" Functions

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

