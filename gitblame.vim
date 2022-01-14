let g:gitblamemode = 0
let g:GBlameVirtualTextEnable = 0

function InitGitBlameMode()
    if g:gitblamemode == 0
        :nnoremap <silent> j j:call gitblame#echo()<CR>
        :nnoremap <silent> k k:call gitblame#echo()<CR>
        :nnoremap <silent> } }:call gitblame#echo()<CR>
        :nnoremap <silent> { {:call gitblame#echo()<CR>
        let g:gitblamemode = 1
    else
        :unmap j
        :unmap k
        :unmap }
        :unmap {
        let g:gitblamemode = 0
    endif
endfunction

nnoremap <silent> <Leader>gb :call InitGitBlameMode()<CR>
