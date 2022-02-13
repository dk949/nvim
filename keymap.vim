" Map the leader key to space
let mapleader = " "


" Comment out a line
map <leader>/ <leader>c<space>


" After moving to a line, bring it to the center of the screen (why is this not default)
map G Gzz


" ctrl-c to copy, ctrl-shift-v to paste
vnoremap <C-C> "*y :let @+=@*<CR>


" toggle NERDtree file browser
map <leader>nn :NERDTreeToggle<CR>

" show minimap
map <leader>nm :MinimapToggle<CR>


" clear the yank buffer
" TODO: consider changing this to a different key
nnoremap <leader>, :let @/=""<CR>


" Enter in normal mode does what enter in insert mode does
"nnoremap <CR> o<esc>


" Navigate windows with ctrl-h ctrl-j etc
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Double escape to get to normal mode in terminal mode
tnoremap <silent> <C-[><C-[> <C-\><C-n>


" Navigate tabs with alt-h and alt-l
map <A-l>  :tabnext<CR>
map <A-h>  :tabNext<CR>


" Disable Arrow keys in Normal mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>


" Disable Arrow keys in Insert mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>


" Enter the name of the file to be opened in a new tab
nnoremap <leader>t :tabedit

" Terminal stuff
" <C-R> paste
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'


" Save the current session
" TODO: consider changing to a different key
nnoremap <leader>ms :mksession!<CR>


" Adding 9 and 0 as substitutes for ( and )
nnoremap di9 di(
nnoremap di0 di)
nnoremap da9 da(
nnoremap da0 da)
nnoremap ci9 ci(
nnoremap ci0 ci)
nnoremap ca9 ca(
nnoremap ca0 ca)

" vv selects the whole line.
nnoremap vv V


" V selects from current position until the end of the line.
nnoremap V v$


" Y copies from current position until the end of the line
nnoremap Y y$


" Load the last loaded buffer
" TODO: Consider a different key
nnoremap <leader>b :e#<CR>


" Save the file
noremap <Leader>s :update<CR>


" cursor highlighting
nnoremap <Leader>mc :set cursorline! <CR>

" special characters with no modifiers
inoremap <F1> !
inoremap <F2> @
inoremap <F3> #
inoremap <F4> $
inoremap <F5> %
inoremap <F6> ^
inoremap <F7> &
inoremap <F8> *
inoremap <F9> (
inoremap <F10> )


" # Function to permanently delete views created by 'mkview'
function! DeleteView()
    let path = fnamemodify(bufname('%'),':p')
    " vim's odd =~ escaping for /
    let path = substitute(path, '=', '==', 'g')
    if empty($HOME)
    else
        let path = substitute(path, '^'.$HOME, '\~', '')
    endif
    let path = substitute(path, '/', '=+', 'g') . '='
    " view directory
    let path = &viewdir.'/'.path
    call delete(path)
    echo "Deleted: ".path
endfunction

" # Command Delview (and it's abbreviation 'delview')
command Delview call DeleteView()
" Lower-case user commands: http://vim.wikia.com/wiki/Replace_a_builtin_command_using_cabbrev
cabbrev delview <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Delview' : 'delview')<CR>


" disable ex mode
:nnoremap Q <Nop>


" quickfix stuff
nnoremap <expr> j &buftype ==# 'quickfix' ? ":cnext\<CR>:wincmd p\<CR>" : 'j'
nnoremap <expr> k &buftype ==# 'quickfix' ? ":cprevious\<CR>:wincmd p\<CR>" : 'k'
nnoremap <expr> <CR> &buftype ==# 'quickfix' ? ":cc\<CR>" : "\<CR>"


" window size
const g:increaseWindowBy = 5
function! ChangeWindowSize(vert, letter)
    let l:winIncState = ''
    if(winnr('$') <=# 1)
        return
    endif

    let l:vert = ''
    if(a:vert)
        let l:vert = 'vert '
    endif

    let l:winnr = winnr()

    exec 'wincmd ' . a:letter

    if(l:winnr !=# winnr())
        wincmd p
        let l:winIncState = '+'
    else
        let l:winIncState = '-'
    endif

    exec l:vert . 'resize ' . l:winIncState . g:increaseWindowBy
endfunction


nnoremap <C-A-h> :silent call ChangeWindowSize(1,'h')<CR>
nnoremap <C-A-j> :silent call ChangeWindowSize(0,'j')<CR>
nnoremap <C-A-k> :silent call ChangeWindowSize(0,'k')<CR>
nnoremap <C-A-l> :silent call ChangeWindowSize(1,'l')<CR>


function FuncNewF()
    const l:ft = &filetype
    vert new
    let &filetype = l:ft
endfunction

" Split vetically with a new buffer
command! New :vert new
command! NewF call FuncNewF()
nnoremap <C-n> :New<CR>

" show current highlight group
command! EchoHl echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . '> lo<' . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"
