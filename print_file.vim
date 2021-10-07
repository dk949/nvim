function! s:_PrintFile(modifier)
    const l:fullName = expand("%:" . a:modifier)
    put =l:fullName
endfunction

":p		expand to full path
command PrintFileFullName :call s:_PrintFile('p')

":t		tail (last path component only)
command PrintFileName :call s:_PrintFile('t')

":h		head (last path component removed)
command PrintFileDirAbs :call s:_PrintFile('p:h')

":h		head (last path component removed)
command PrintFileDirRel :call s:_PrintFile('h')



