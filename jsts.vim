" javascript and typescript config


setlocal colorcolumn=+1
highlight ColorColumn ctermbg=6
setlocal textwidth=120

function! InitFolds()
    :setlocal foldmethod=syntax
    :norm zR
endfunction
call InitFolds()


" Adding curly braces after the brackets
nnoremap <leader>[ A{<CR>}<esc><S-o><esc>
nnoremap <leader>{ A{<CR>}<esc><S-o>


" Place a semicolon at the end of a line
nnoremap <leader>; A;<esc>


"Run the formatter/fixer
xmap <leader>mf <Plug>(coc-format)
nmap <leader>mf <Plug>(coc-format)

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
