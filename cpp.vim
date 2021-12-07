" Set folding method for cpp files

setlocal colorcolumn=+1
highlight ColorColumn ctermbg=6
setlocal textwidth=120

function! InitFolds()
    :setlocal foldmethod=manual
    :norm zR
endfunction
call InitFolds()


" Adding curly braces after the brackets
nnoremap <leader>[ A{<CR>}<esc><S-o><esc>
nnoremap <leader>{ A{<CR>}<esc><S-o>


" Place a semicolon at the end of a line
nnoremap <leader>; A;<esc>



"Run the formatter
command! Format :silent execute "!clang-format --style=file -i %"
nnoremap <buffer> <leader>mf :Format<CR>:e<CR>


" Find the next " ' or ] or } or ), step over it and go into insert mode
" TODO: Consider a different key map
function! StepOver()
    :norm mm
    for counter in split(getline('.'), '\zs')[col('.'):]
        if counter == "]"
            :norm f]
            :call feedkeys('a', 'n')
            break
        elseif counter == ")"
            :norm f)
            :call feedkeys('a', 'n')
            break
        elseif counter == "}"
            :norm f}
            :call feedkeys('a', 'n')
            break
        endif
    endfor
endfunction
nnoremap <leader><space> :call StepOver()<CR>

" TODO: create a mode for this?
" closing the brackets
" Maybe someday this will be more useful
"inoremap ' ''<esc>i
"inoremap " ""<esc>i
"inoremap ( ()<esc>i
"inoremap [ []<esc>i
"inoremap { {}<esc>i

" cpp highligh options
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1


" cpp linting options
let g:syntastic_cpp_checkers = ['cpplint']
let g:syntastic_c_checkers = ['cpplint']
let g:syntastic_cpp_cpplint_exec = 'cpplint'
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


" Tags
"command! MakeTags !ctags -Ra .
"MakeTags
"nnoremap <leader>mt :silent execute "MakeTags"<CR>

