" Will type increasingly larger numbers
" TODO: This needs a rewrite
let g:currNum = 0
function! NextNum()
    let @n = g:currNum
    :norm "nP
    let g:currNum = g:currNum + 1
endfunction

function! ZeroNum()
    let g:currNum = 0
endfunction


" <leader>ln to paste the next value
nnoremap <leader>ln :call NextNum()<CR>


" <leader>lz to paste xero out the counter
nnoremap <leader>lz :call ZeroNum()<CR>
