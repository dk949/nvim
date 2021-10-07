function! s:_GitGetFileName(filename)
    const res =  system('git ' . 'ls-files --full-name ' . a:filename)
    echo res
    return res
endfunction

function! s:_GitEditOld(...)
    const l:usage = "Usage: cmd FILENAME | cmd REF FILENAME."
    const l:numArgs = a:0
    if (l:numArgs > 2)
        echoerr "Too many arguments " . usage
        return
    endif

    if (l:numArgs ==# 0)
        const l:filename = s:_GitGetFileName(expand('%:p'))
        const l:ref = "HEAD"
        const l:ft = &filetype
        vert new
        let &filetype = l:ft
    elseif (l:numArgs ==# 1)
        const l:filename = a:1
        const l:ref = "HEAD"
    else
        const l:ref = a:1
        const l:filename = a:2
    endif

    exec 'silent read !git cat-file blob ' . l:ref . ':' . l:filename
endfunction

command! -nargs=? GitEditOld :silent call s:_GitEditOld(<f-args>)
cabbrev ge GitEditOld

function! s:_GitDiffThis(...)
    const l:usage = "Usage: cmd | cmd REF ."
    const l:numArgs = a:0
    if (l:numArgs > 1)
        echoerr "Too many arguments " . usage
        return
    endif

    const l:filename = s:_GitGetFileName(expand('%:p'))
    if (l:numArgs ==# 0)
        const l:ref = "HEAD"
    else
        const l:ref = a:1
    endif

    const l:ft = &filetype
    exec 'vert diffsplit ' . tempname()
    exec 'silent read !git cat-file blob ' . l:ref . ':' . l:filename
    let &filetype = l:ft
endfunction


command! -nargs=? GitDiffThis :silent call s:_GitDiffThis(<f-args>)
cabbrev gd GitDiffThis
