let g:RgArgs = " -l"
let g:RgSplitAmmount = 7
let g:RgChangeCursorColor = 0

function! RgCopyHihlight(hl)
    let l:bgVal = synIDattr(hlID(a:hl),'bg')
    let l:fgVal = synIDattr(hlID(a:hl),'fg')
    let l:bg = (has("gui_running")? 'guibg=':'ctermbg=') . (l:bgVal ==# '' ? "NONE": l:bgVal)
    let l:fg = (has("gui_running")? 'guifg=':'ctermfg=') . (l:fgVal ==# '' ? "15": l:fgVal)
    return [l:bg, l:fg]
endfunction


function! RgSetBufOpts()

    " Options for a non-file/control buffer.
    setlocal bufhidden=hide
    setlocal buftype=nofile
    setlocal noswapfile

    " Options for controlling buffer/window appearance.
    setlocal  foldcolumn=0
    setlocal  foldmethod=manual
    setlocal  nobuflisted
    setlocal  nofoldenable
    setlocal  nolist
    setlocal  nospell
    setlocal  nowrap


    if(g:RgChangeCursorColor)
        let l:hlCursor = RgCopyHihlight('Pmenu')
    else
        let l:hlCursor = RgCopyHihlight('CursorLine')
    endif

    exec 'hi CursorLine ' . l:hlCursor[0] . ' ' . l:hlCursor[1]

    setlocal number

    iabc <buffer>

    setlocal cursorline
    setlocal switchbuf=useopen

    nmap <buffer> <CR> :silent call RgOpenFileFunc()<CR>
endfunction

function! RgDoSearch(cwd, searchTerm) abort
    let l:searchResult = system("rg " . '"' . a:searchTerm . '"' . g:RgArgs)
    let l:searchResult = split(l:searchResult, '\n')
    return l:searchResult
endfunction

function! RgFunc(searchTerm) abort
    let l:cwd = expand('%:p:h')
    let l:searchResult = RgDoSearch(l:cwd, a:searchTerm)

    let l:splitAmmount = len(l:searchResult) > g:RgSplitAmmount ? g:RgSplitAmmount : len(l:searchResult)

    let @/ = a:searchTerm

    exec l:splitAmmount . " new"
    for l:i in l:searchResult
        put =l:i
    endfor

    norm! ggdd
    call RgSetBufOpts()
endfunction!

function! RgOpenFileFunc()
    let l:newFile = getline('.')
    echo l:newFile

    wincmd c
    exec "e " . l:newFile
    silent norm! ggn
endfunction

function! RgVisualSearch() range
    let l:saved = @g
    norm! gv"gy
    let l:val = @g
    let @g = l:saved

    call RgFunc(l:val)
endfunction

command! -nargs=1 Rg :call RgFunc(<q-args>)

nnoremap <leader>rg :Rg
vnoremap <leader>rg :call RgVisualSearch()<CR>
