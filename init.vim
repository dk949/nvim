" Core functionality used with every file
source $XDG_CONFIG_HOME/nvim/core.vim

" Core key maps
source $XDG_CONFIG_HOME/nvim/keymap.vim

" Plugins
source $XDG_CONFIG_HOME/nvim/plugins.vim

" wiki
source $XDG_CONFIG_HOME/nvim/vimwikiconfig.vim

" Abbreviations
source $XDG_CONFIG_HOME/nvim/abbriviations.vim

" Telescope
source $XDG_CONFIG_HOME/nvim/telescopeconfig.vim

" c++
au filetype cpp,c source $XDG_CONFIG_HOME/nvim/cocconfig.vim
au filetype cpp,c source $XDG_CONFIG_HOME/nvim/doxygen.vim
au filetype cpp,c source $XDG_CONFIG_HOME/nvim/cpp_lint.vim
au filetype cpp,c source $XDG_CONFIG_HOME/nvim/cpp.vim
source $XDG_CONFIG_HOME/nvim/snippets.vim

" d
au filetype d source $XDG_CONFIG_HOME/nvim/d.vim


" cmake
au filetype cmake source $XDG_CONFIG_HOME/nvim/cocconfig.vim
au filetype cmake source $XDG_CONFIG_HOME/nvim/cmake.vim


" js/ts
au filetype javascript,typescript,javascriptreact,typescriptreact source $XDG_CONFIG_HOME/nvim/cocconfig.vim
au filetype javascript,typescript,javascriptreact,typescriptreact source $XDG_CONFIG_HOME/nvim/jsts.vim

"json
au filetype json source $XDG_CONFIG_HOME/nvim/cocconfig.vim
au filetype json source $XDG_CONFIG_HOME/nvim/json.vim

"xml
au filetype xml source $XDG_CONFIG_HOME/nvim/xml.vim


" python
au filetype python source $XDG_CONFIG_HOME/nvim/python.vim
au filetype python source $XDG_CONFIG_HOME/nvim/cocconfig.vim

" haskell
au filetype haskell source $XDG_CONFIG_HOME/nvim/cocconfig.vim
au filetype haskell source $XDG_CONFIG_HOME/nvim/haskell.vim
au filetype haskell source $XDG_CONFIG_HOME/nvim/aleconfig.vim

" rust
au filetype rust source $XDG_CONFIG_HOME/nvim/cocconfig.vim
au filetype rust source $XDG_CONFIG_HOME/nvim/rust.vim

" markdown
au filetype markdown source $XDG_CONFIG_HOME/nvim/md.vim

" zig
au filetype zig source $XDG_CONFIG_HOME/nvim/cocconfig.vim

" roc
au BufRead,BufNewFile *.roc source $XDG_CONFIG_HOME/nvim/roc.vim

" asm
au BufRead,BufNewFile *.asm source $XDG_CONFIG_HOME/nvim/asm.vim

" TeX
au filetype tex source $XDG_CONFIG_HOME/nvim/tex.vim
