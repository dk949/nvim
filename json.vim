syntax match Comment +\/\/.\+$+

command! Format :silent execute "%!jq ."
nnoremap <leader>mf :Format<CR>:w<CR>:e<CR>

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
