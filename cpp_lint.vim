" Adapted from Brendan Robeson's https://github.com/brobeson/Tools

" check if this plug-in (or one with the same name) has already been loaded
if exists('b:loaded_cpp_cppcheck')
    finish
endif
const b:loaded_cpp_cppcheck = 1

" save cpoptions and reset to avoid problems in the script
let s:save_cpo = &cpo
setlocal cpo&vim

" ensure that the options and path variables have been defined. if the
" user hasn't done so, set them up with defaults
if !exists('g:cpp_cppcheck_options')
    const g:cpp_cppcheck_options = '--suppress=missingIncludeSystem --suppress=unusedFunction --suppress=unmatchedSuppression --enable=all --inline-suppr --inconclusive -I ' . expand('%:h')
endif

if !exists('g:clang_tidy_options')
    const g:clang_tidy_options = '-extra-arg=-Wno-unknown-warning-option'
endif

" add to the error format, so the quick fix window can be used. clang-tidy and cppcheck use the same format
setlocal efm+=%f:%l:\ %m


" create the command to run Cppcheck
if !exists(':Cpplint')
    command -buffer Cpplint :call s:RunCpplint()
    nnoremap <leader>ml :Cpplint<CR>
endif

" the function to do the work
if !exists('*s:RunCpplint')
    function s:RunCpplint() abort
        if executable('cppcheck') == 0
            echo 'Cppcheck cannot be found. Ensure the path to cppcheck is in your PATH environment variable.'
            return
        endif
        if executable('clang-tidy') == 0
            echo 'clang-tidy cannot be found. Ensure the path to cppcheck is in your PATH environment variable.'
            return
        endif
        const l:start_cmd = 'silent !'
        const l:cppcheck_cmd = 'cppcheck ' . g:cpp_cppcheck_options . ' ' . expand('%:p') . ' 2> ' . &errorfile . '; '
        const l:clang_tidy_cmd = 'clang-tidy ' . g:clang_tidy_options . ' ' . expand('%:p') . ' 1>> ' . &errorfile

        execute l:start_cmd . l:cppcheck_cmd . l:clang_tidy_cmd
        cgetfile
        copen
    endfunction
endif

" restore the original cpoptions
let &cpo = s:save_cpo
unlet s:save_cpo
