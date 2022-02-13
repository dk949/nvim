xmap <leader>mf <Plug>(coc-format)
nmap <leader>mf <Plug>(coc-format)

"function FormatHTML()
    "let b:winview = winsaveview()
    "norm gg=G
    "call winrestview(b:winview)
"endfunction
"command! -buffer Format :silent call FormatHTML()
"nnoremap <buffer> <leader>mf :Format<CR>:w<CR>:e<CR>
