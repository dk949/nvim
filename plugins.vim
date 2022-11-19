
function s:checkPlug()
    if (!filereadable(stdpath("data") . "/site/autoload/plug.vim"))
        echohl WarningMsg
        echo "WARNING: plug.vim not found trying to download..."
        echohl None
        call system('curl -fLo ' \
            . stdpath("data") . "/site/autoload/plug.vim " \
            . '--create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
        if(v:shell_error)
            echohl WarningMsg
            echo "ERROR: plug.vim could not be downloaded"
            echohl None
            finish
        endif
    endif
endfunction

" My plugins
" Space mode plugin
source $XDG_CONFIG_HOME/nvim/spacemode.vim

" Line count plugin
source $XDG_CONFIG_HOME/nvim/linecount.vim

" Hex editor plugin
source $XDG_CONFIG_HOME/nvim/hexedit.vim

" Man page viewing
source $XDG_CONFIG_HOME/nvim/man.vim

" ripgrep
source $XDG_CONFIG_HOME/nvim/ripgrep.vim

" terminal
source $XDG_CONFIG_HOME/nvim/term.vim

" PrintFile
source $XDG_CONFIG_HOME/nvim/print_file.vim

" Git
source $XDG_CONFIG_HOME/nvim/git.vim

" Maths
source $XDG_CONFIG_HOME/nvim/maths.vim

" Plugins loaded with the Vundle plugin manager
" TODO: consider switching to Plug


call s:checkPlug()

call plug#begin()

" let Vundle manage Vundle, required
Plug 'VundleVim/Vundle.vim'

" Vim powerline plugin
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" File explorer (NERDTree)
Plug 'preservim/nerdtree'

" Comments (NERDComenter)
Plug 'preservim/nerdcommenter'

" Vim surround
Plug 'tpope/vim-surround'

" color scheme
Plug 'dracula/vim'

" Vim wiki
Plug 'vimwiki/vimwiki'

" C++ support
Plug 'neoclide/coc.nvim', {'tag': 'v0.0.82'}
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'vim-syntastic/syntastic'

" d
Plug 'idanarye/vim-dutyl'

" peg
Plug 'dk949/pegged.vim'

" linting
Plug 'dense-analysis/ale'

" Haskell support
Plug 'neovimhaskell/haskell-vim'

" jsx/tsx support
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'eliba2/vim-node-inspect'

" python
" Plug 'numirias/semshi', { 'for': 'python' }

" highlight yank
Plug 'machakann/vim-highlightedyank'

" plant uml
Plug 'aklt/plantuml-syntax'

" rust
Plug 'rust-lang/rust.vim'

" git blame
Plug 'zivyangll/git-blame.vim'

" 6502 asm
Plug 'maxbane/vim-asm_ca65'

" Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" Zig
Plug 'ziglang/zig.vim'

" purescript
Plug 'purescript-contrib/purescript-vim'

" dhall
Plug 'vmchale/dhall-vim'

" telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" minimap
Plug 'wfxr/minimap.vim'

" Fluent
Plug 'projectfluent/fluent.vim'

" indent highlighting
Plug 'lukas-reineke/indent-blankline.nvim'

"asterisp
Plug '~/code/vim/asterisp.vim/'

"Scotch
"Plug 'dk949/scotch.vim'
call plug#end()

let g:coc_start_at_startup = 0
let g:ale_enabled = 0
let g:ale_disable_lsp = 1

let NERDTreeShowHidden=1

let g:minimap_git_colors = 1
let g:minimap_width = 15

" git blame
source $XDG_CONFIG_HOME/nvim/gitblame.vim

" Colours and airline
source $XDG_CONFIG_HOME/nvim/look.vim
