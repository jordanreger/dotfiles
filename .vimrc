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

" LSP
let g:lsp_diagnostics_enabled = 0
let g:lsp_use_native_client = 1

if executable('clangd')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'clangd',
    \ 'cmd': {server_info->['clangd', '-background-index']},
    \ 'allowlist': ['c', 'cpp', 'objc', 'objcpp'],
    \ })
endif

if executable('gopls')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'gopls',
    \ 'cmd': {server_info->['gopls', '-remote=auto']},
    \ 'allowlist': ['go', 'gomod', 'gohtmltmpl', 'gotexttmpl'],
    \ })
  autocmd BufWritePre *.go
    \ call execute('LspDocumentFormatSync') |
    \ call execute('LspCodeActionSync source.organizeImports')
endif

if executable('rust-analyzer')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'rust-analyzer',
    \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rust-analyzer']},
    \ 'allowlist': ['rust'],
    \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> K <plug>(lsp-hover)
endfunction

augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" Autocomplete
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
