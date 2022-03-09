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

set nocompatible              " be iMproved,:se required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin('~/.config/nvim/bundle/')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Vim powerline plugin
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" File explorer (NERDTree)
Plugin 'preservim/nerdtree'

" Comments (NERDComenter)
Plugin 'preservim/nerdcommenter'

" Vim surround
Plugin 'tpope/vim-surround'

" color scheme
Plugin 'dracula/vim'

" Vim wiki
Plugin 'vimwiki/vimwiki'

" C++ support
Plugin 'neoclide/coc.nvim'
Plugin 'jackguo380/vim-lsp-cxx-highlight'
Plugin 'vim-syntastic/syntastic'

" d
Plugin 'SirVer/ultisnips'
Plugin 'idanarye/vim-dutyl'

" linting
Plugin 'dense-analysis/ale'

" Haskell support
Plugin 'neovimhaskell/haskell-vim'

" jsx/tsx support
Plugin 'leafgarland/typescript-vim'
Plugin 'peitalin/vim-jsx-typescript'
Plugin 'eliba2/vim-node-inspect'

" python
Plugin 'numirias/semshi'

" highlight yank
Plugin 'machakann/vim-highlightedyank'

" rust
Plugin 'rust-lang/rust.vim'

" git blame
Plugin 'zivyangll/git-blame.vim'

" 6502 asm
Plugin 'maxbane/vim-asm_ca65'

" Markdown
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

" Zig
Plugin 'ziglang/zig.vim'

" purescript
Plugin 'purescript-contrib/purescript-vim'

" dhall
Plugin 'vmchale/dhall-vim'

" telescope
Plugin 'nvim-lua/plenary.nvim'
Plugin 'nvim-telescope/telescope.nvim'

" minimap
Plugin 'wfxr/minimap.vim'

" Fluent
Plugin 'projectfluent/fluent.vim'

call vundle#end()            " required
filetype plugin indent on    " required

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
