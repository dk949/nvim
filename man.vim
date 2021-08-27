cnoreabbrev Vman vert Man
vnoremap <leader>mm :call GetManVisual()<CR>

function! GetManVisual() range
    let l:saved = @g
    norm! gv"gy
    let @g = l:saved

    exe "vert Man " . @g
endfunction

