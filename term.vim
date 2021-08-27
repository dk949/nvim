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
