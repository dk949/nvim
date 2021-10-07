command! -buffer Format :silent execute "%!xmllint --format -"
nnoremap <buffer> <leader>mf :Format<CR>:w<CR>:e<CR>
