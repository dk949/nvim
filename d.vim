" dlang

setlocal colorcolumn=+1
highlight ColorColumn ctermbg=6
setlocal textwidth=120

"set runtimepath^=$HOME/src/coc-dlang/

function! InitFolds()
    :setlocal foldmethod=syntax
    :norm zR
endfunction
call InitFolds()

"Run the formatter/fixer
command! Format :silent execute "!dfmt -i %"
nnoremap <buffer> <leader>mf :Format<CR>:e<CR>

" make = dub
let s:save_cpo = &cpo
set cpo&vim

setlocal makeprg=dub

let &cpo = s:save_cpo
unlet s:save_cpo

" dutyl stuff
"DUDCDstartServer " start server
"let g:dutyl_dontHandleFormat = 0
"let g:dutyl_dontHandleIndent = 0
"let g:dutyl_neverAddClosingParen=0
""let g:dutyl_stdImportPaths=['/usr/include/dlang/dmd']
"let g:dutyl_tagsFileName='tags'
