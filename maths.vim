function! s:get_visual_selection()
    " https://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return [join(lines, "\n"), column_start, column_end]
endfunction


" put selected text trhough the expression register and replace it with the result
function! VisualMath() range
    let [text, column_start, column_end] = s:get_visual_selection()
    call feedkeys(column_start . "|" . "d" . column_end . "|")
    call feedkeys("i\<C-r>=" . l:text . "\<CR>\<ESC>")
endfunction

vnoremap <leader>m= :call VisualMath()<CR>
