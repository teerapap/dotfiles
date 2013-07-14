" Pathogen
execute pathogen#infect()

" Line number
set number

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

" Key mappings
nnoremap <silent> ,/ :let@/=""<CR>   " clear search pattern
cnoremap q1 q!                       " typo q1




" For Python
au FileType py set autoindent
au FileType py set smartindent
au FileType py set textwidth=79 " PEP-8 Friendly

