function! StartDoxyComment() abort
    let l:save = @g



    :norm! ^
    let l:curpos = getpos('.')
    let l:spacing=repeat(' ', l:curpos[2] - 1)
    let @g = l:spacing . '/*!'
    :-1put g
    let @g = l:spacing . ' * \brief '
    :put g
    let @g = l:spacing . ' *'
    :put g
    :put g
    let @g = l:spacing . ' */'
    :put g
    call cursor(l:curpos[1] + 1, l:curpos[2])


    let @g=l:save
endfunction


nnoremap <leader>md :call StartDoxyComment()<CR>



