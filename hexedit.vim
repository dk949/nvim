" vim -b : edit binary using xxd-format!
augroup Binary
    au!
    au BufWritePre *.out,*.bin,*.img let b:winview = winsaveview()
    au BufWritePost *.out,*.bin,*.img call winrestview(b:winview)

    au BufReadPre  *.out,*.bin,*.img let &bin=1
    au BufReadPost *.out,*.bin,*.img if &bin | %!xxd
    au BufReadPost *.out,*.bin,*.img set ft=xxd | endif
    au BufWritePre *.out,*.bin,*.img if &bin | %!xxd -r
    au BufWritePre *.out,*.bin,*.img endif
    au BufWritePost *.out,*.bin,*.img if &bin | %!xxd
    au BufWritePost *.out,*.bin,*.img set nomod | endif
augroup END

