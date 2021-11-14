command! Format :silent !formark -f % -o %

nnoremap <leader>mf :Format<CR>:e<CR>

setlocal spell

let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets  = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_no_default_key_mappings = 1


set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
