if !exists("g:haskell_repl")
    let g:haskell_repl = 1
    let cmd = "stack repl " . expand("%")
    new
    let g:ghci_session_id = termopen(cmd)
    call chansend(g:ghci_session_id, ":!clear\n")
    ""exec 'resize ' . string(&lines *  0.20)
    resize 8
endif


au BufWrite * call GHCiRefresh()
au BufAdd * call GHCiAddFile()

vnoremap <leader>r :call RunInReplVisual()<CR>

function! GHCiRefresh()
    if exists("g:ghci_session_id")
        call chansend(g:ghci_session_id, ":load " . expand('%') . "\n")
        call chansend(g:ghci_session_id, ":!clear\n")
    endif
endfunction


function! GHCiAddFile()
    if exists("g:ghci_session_id")
        call chansend(g:ghci_session_id, ":load " . bufname('$') . "\n")
        call chansend(g:ghci_session_id, ":!clear\n")
    endif
endfunction

xmap <leader>mf <Plug>(coc-format)
nmap <leader>mf <Plug>(coc-format)


let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
let g:haskell_classic_highlighting = 0    " more traditional highlighting
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
