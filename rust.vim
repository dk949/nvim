" rustup component add rls rust-analysis rust-src
" rustup component add rustfmt.

nnoremap <buffer> <leader>mf :RustFmt<CR>:w<CR>
