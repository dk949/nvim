



" REQUIRES: pdftotext
if(!executable("pdftotext"))
    echohl WarningMsg
    echo "WARNING: pdftotext could not be found"
    echohl None
    finish
endif

let b:currPage = 1
setlocal buftype=nofile
setlocal bufhidden=hide
setlocal noswapfile

function! s:loadPage(num)
    setlocal modifiable
    setlocal noreadonly
    %d
    exec "-1 read !pdftotext % -nopgbrk -f ". a:num .' -l '. a:num .' -'
    if(v:shell_error)
        undo
        let b:currPage = b:currPage - 1
    endif

    setlocal readonly
    setlocal nomodifiable
endfunction

function! ChPage(dir)
    let b:currPage = b:currPage + a:dir
    if(b:currPage < 1)
        let b:currPage = 1
    endif
    call s:loadPage(b:currPage)
endfunction

call s:loadPage(b:currPage)

map <right> :call ChPage(1)<CR>
map <left> :call ChPage(-1)<CR>


