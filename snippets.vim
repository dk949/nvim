" Snippets
function! Snippethpp()
    let l:define_name = substitute(toupper(expand("%:t")), '\.', '_', "g")
    let l:l0 = "#ifndef " . l:define_name
    let l:l1 = "\n#define " . l:define_name
    let l:l2 = "\n\n\n#endif // " . l:define_name
    let l:all = l0 . l1 . l2

    let l:save = @g
    -1put =l:all
    :3

    let @g = l:save
endfunction

function! Snippetcpp()
    :-1read $XDG_DATA_HOME/snippets/.cpp
    :norm jA
    :startinsert!
endfunction

function! Snippetc()
    :-1read $XDG_DATA_HOME/snippets/.c
    :norm jA
    :startinsert!
endfunction

au BufNewFile *.h,*.hpp call Snippethpp()
au BufNewFile main.cpp call Snippetcpp()
au BufNewFile main.c call Snippetc()
