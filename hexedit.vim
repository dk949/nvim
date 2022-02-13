" vim -b : edit binary using xxd-format!
augroup Binary
    au!
    au BufWritePre  *.out,*.bin,*.img let b:winview = winsaveview()
    au BufWritePost *.out,*.bin,*.img call winrestview(b:winview)
    au BufReadPre *.out,*.bin,*.img vnoremap <leader>hd :call DecodeAs()<CR>

    au BufReadPre   *.out,*.bin,*.img let &bin=1
    au BufReadPost  *.out,*.bin,*.img if &bin | %!xxd
    au BufReadPost  *.out,*.bin,*.img set ft=xxd | endif
    au BufWritePre  *.out,*.bin,*.img if &bin | %!xxd -r
    au BufWritePre  *.out,*.bin,*.img endif
    au BufWritePost *.out,*.bin,*.img if &bin | %!xxd
    au BufWritePost *.out,*.bin,*.img set nomod | endif
augroup END



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
    return join(lines, "\n")
endfunction

function DecodeAs() range
    py3 << EOF

def part(l, n): return (l[i:i + n] for i in range(0, len(l), n))

text = vim.eval('s:get_visual_selection()')
text = ''.join(text.split())
text = list(map(lambda x: int(x, 16), part(text, 2)))
print(''.join(map(chr, text)))

EOF

endfunction


