" Automatically add changed files to git
au BufWritePost init.vim :silent execute "!cd ~/install && git add .config/nvim/init.vim"
au BufWritePost .bashrc :silent execute "!cd ~/install && git add .bashrc"
au BufWritePost .bash_profile :silent execute "!cd ~/install && git add .bash_profile"
au BufWritePost .bash_aliases :silent execute "!cd ~/install && git add .bash_aliases"


" Automatically sync the spelling dictionary
function! UpdateSpell()
    :silent execute "!cd ~/install && git add .config/nvim/spell"
endfunction

nnoremap zg zg:call UpdateSpell()<CR>
