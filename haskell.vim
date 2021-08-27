 "split
 "term ghci %
 "call jobsend(4, ":!clear\n")
 ""exec 'resize ' . string(&lines *  0.20)
 "resize 8

 "au BufWrite * call GHCiRefresh()

 "vnoremap <leader>r :call RunInReplVisual()<CR>
 "const g:haskell_repl = 1

 "function! GHCiRefresh()
     "call jobsend(4, ":r\n")
     "call jobsend(4, ":!clear\n")
 "endfunction


 "function! RunInReplVisual() range
     "let l:saved = @g
     "norm! gv"gy
     "call jobsend(4, @g . "\n")
     "let @g = l:saved
 "endfunction

xmap <leader>mf <Plug>(coc-format)
nmap <leader>mf <Plug>(coc-format)



let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
let g:haskell_classic_highlighting = 1    " more traditional highlighting
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
