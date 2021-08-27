"Run the formatter
command! CMakeFormat :silent execute "!cmake-format -i %"
nnoremap <leader>mf :CMakeFormat<CR>:e<CR>

nnoremap <leader>mm :call GetManVisual()<CR>

function! GetManVisual()
    :CocCommand cmake.onlineHelp
endfunction

