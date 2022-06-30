command! Format :silent execute "!dfmt -i %"
nnoremap <buffer> <leader>mf :Format<CR>:e<CR>

let s:save_cpo = &cpo
set cpo&vim

setlocal makeprg=dub

let &cpo = s:save_cpo
unlet s:save_cpo

