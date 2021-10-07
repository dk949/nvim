syntax match Comment +\/\/.\+$+

command! -buffer Format :silent execute "%!jq ."
nnoremap <buffer> <leader>mf :Format<CR>:w<CR>:e<CR>

setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal expandtab


