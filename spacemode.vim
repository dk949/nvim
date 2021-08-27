" Pseudo mode in which j, k, and the curly braces keep text in the middle of the page
let g:inSpace = 0
function! SpaceMode()
    if g:inSpace == 0
        :map j jzz
        :map k kzz
        :map } }zz
        :map { {zz
        let g:inSpace = 1
    else
        :unmap j
        :unmap k
        :unmap }
        :unmap {
        let g:inSpace = 0
    endif
endfunction

" Toggle the mode with leader x
nnoremap <leader>x :call SpaceMode()<CR>
