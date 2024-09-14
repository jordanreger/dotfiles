set splitbelow
set termwinsize=12x0

set number relativenumber
set ignorecase
set incsearch

set re=0
filetype plugin indent on
syntax on

set autoindent
set cindent
set shiftwidth=2
set smartindent
set smarttab
set softtabstop=2	
 
set ruler	
set noerrorbells

set mouse=a

autocmd BufLeave * if &buftype=="terminal" | setlocal nobuflisted | endif
nnoremap <silent> <C-j> :bnext<CR>
nnoremap <silent> <C-k> :bprev<CR>

imap <C-e> <esc>$i<right>
imap <C-a> <esc>0i
map <C-e> <esc>$<right>
map <C-a> <esc>0
