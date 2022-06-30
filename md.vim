setlocal ft=markdown " for filetypes which should be interpreted as markdown but are not by default
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal expandtab
setlocal spell

command! Format :silent !formark -f % -o %

setlocal colorcolumn=+1
highlight ColorColumn ctermbg=6
setlocal textwidth=80

nnoremap <buffer> <leader>mf :Format<CR>:e<CR>
"nnoremap <buffer> <leader>mf mggg=G`g


let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets  = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_no_default_key_mappings = 1


