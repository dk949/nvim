augroup TermAU
 autocmd VimEnter  * :call SetTermVar()
 autocmd VimLeave * :call UnSetTermVar()
augroup END

function! SetTermVar()
    let $NVIM_TERMINAL = "1"
endfunction


function! UnSetTermVar()
    let $NVIM_TERMINAL = ""
endfunction

function! MakeTerm()
   const l:width = winwidth(0)
   const l:height = winheight(0)

   if(l:width < l:height * 2) " correcting for aspet ratio
       :split
   else
       :vsplit
   endif

   :term
   :startinsert
endfunction


command! MakeTerm :call MakeTerm()
nnoremap <leader>mt :MakeTerm<CR>
