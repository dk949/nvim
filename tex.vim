autocmd BufWritePost * call Compile()

" Spellchecking
set spell


nnoremap j gj
nnoremap gj j

nnoremap k gk
nnoremap gk k

function! Compile()
    " save current window position
    let l:winview = winsaveview()

    " Move cursor to the start of the document
    call cursor(1, 1)

    " Look fr the string 'subfiles' in the first line of the buffer
    if (search("subfiles", '', 1))

        " If the string is found, save the last item that was yanked
        let l:saved = @0

        " Go to the beginning of the buffer and yank everything that is in the square brackets
        norm gg0f[yi[

        " Move the yanked text into a variable, this text should be the location of the main file
        let l:raw_filename = @0

        " Split the string on forward slash
        let l:fullPath = split(l:raw_filename, '/')

        " Take everything except the last element and join it on the forward slash, that is the directory
        let l:directory = join(l:fullPath[0:-2], "/")

        " Take the last element and save it separately
        let l:filename = l:fullPath[-1]

        " Check if the directory is empty (main file and this file are in the same directory)
        if (l:directory == "")

            " If so, compile the main file
            let l:cmd = "pdflatex " . l:filename . " >/dev/null 2>&1"
        else

            " If not, use execf (from shellutils), to compile the file relative to the directory it is in
            let l:cmd = "execf " . l:directory ." pdflatex " . l:filename . " >/dev/null 2>&1"
        endif

        " Restore the value of the last yanked item
        let @0 = l:saved

    else
        " If the string 'subfiles' is not found, call the pdflatex command with the name of the current buffer as input (also asynchronously)
        let l:cmd = "pdflatex " . @% . " >/dev/null 2>&1"
    endif
    " Execute the actual compilation command (asynchronously)
    call jobstart(l:cmd)
    " Redraw the buffer just in case
    redraw!

    " return the window to the original position
    call winrestview(l:winview)
endfunction

