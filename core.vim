" Tab completion works better (already on in nvim)
set wildmenu


" Turning on the filetype plugin
filetype plugin on
filetype plugin indent on


" Hybrid numbering in normal mode and normal numbering in insert mode
" TODO: put this in a group
set relativenumber number
au InsertLeave * set relativenumber number
au InsertEnter * set norelativenumber


" Terminal stuff
au TermOpen  * set norelativenumber
au TermOpen  * set nonumber
"au TermOpen  * startinsert
"au TermEnter  * startinsert
autocmd BufWinEnter,WinEnter term://* startinsert


" No autocomments on a new line
au BufEnter * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


" No whitespace at the ned of lines
let g:exclude_no_end_space = ["init.vim",  "Tools.tsx", "snippets.vim"]
au BufWritePre * if index(g:exclude_no_end_space, expand('%:t')) < 0 | %s/\s\+$//e | endif


"setting tabsize
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab


" Remember where in a file the cursor was located. Also remembers folds
augroup remember_file
  autocmd!
  autocmd BufWritePre * :mkview
  autocmd BufEnter * silent! loadview
augroup END


" Lookup things in an online dictionary (requires the dict command)
command! -nargs=1 Dict :!dict <q-args>


" I give up
command! W w


" When searching with only lowercase letters, case will be ignored. Not ignored with capitals.
set ignorecase
set smartcase


" Incremental search
set incsearch


" Search is not highlighted
set nohlsearch


" Search through subdirectories recursively
set path+=**


" Spilts act as expected
set splitbelow
set splitright

" Mouse
set mouse=

" if an error file has been created, delete it when it is no longer needed. FIXME: this is a little heavy handed
"au BufUnload * :silent !rm -f errors.err
