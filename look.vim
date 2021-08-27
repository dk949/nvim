" set vim-airline options
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" Set color scheme
colorscheme dracula
set background=dark
let g:airline_theme='dracula'
syntax on

" Set transparency
au BufEnter * hi Normal guibg=NONE ctermbg=NONE

" Set highlight yank
let g:highlightedyank_highlight_duration = 1000
au BufEnter * hi HighlightedyankRegion cterm=reverse gui=reverse ctermfg=green


" Set options for python semshi
let g:semshi#simplify_markup = v:true
let g:semshi#error_sign = v:false
let g:semshi#tolerate_syntax_errors = v:false " potential perf benefit?
let g:semshi#mark_selected_nodes = 0
let g:semshi#excluded_hl_groups = []

" set colors for semshi
" Salmon1
hi semshiLocal           ctermfg=38 guifg=#ff875f

" Orange1
hi semshiGlobal          ctermfg=214 guifg=#ffaf00

" Honeydew2
hi semshiImported        ctermfg=194 guifg=#D7FFD7

" SteelBlue3
hi semshiParameter       ctermfg=68  guifg=#5F87D7

" Grey50
hi semshiParameterUnused ctermfg=244 guifg=#808080 cterm=underline gui=underline

" Pink1
hi semshiFree            ctermfg=red guifg=#ffafd7

" MediumOrchid
hi semshiBuiltin         ctermfg=225 guifg=#ff5fff

" MediumSpringGreen
hi semshiAttribute       ctermfg=49  guifg=#00ffaf

" Grey70
hi semshiSelf            ctermfg=249 guifg=#b2b2b2

" Yellow1
hi semshiUnresolved      ctermfg=red guifg=#ffff00 cterm=underline gui=underline

"Just in case
" hi semshiErrorSign       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
" hi semshiErrorChar       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
" sign define semshiError text=E> texthl=semshiErrorSign



" set colors for tsx highlighting
" DeepSkyBlue2
hi tsxTagName guifg=#00AFD7 ctermfg=38
hi tsxTag guifg=#00AFD7 ctermfg=38
hi tsxComponentName guifg=#00AFD7 ctermfg=38
hi tsxCloseComponentName guifg=#00AFD7 ctermfg=38

" SteelBlue3
hi tsxCloseTagName guifg=#5F87D7 ctermfg=68
hi tsxCloseTag guifg=#5F97D7 ctermfg=68

" Orange1
hi tsxCloseString guifg=#FFAF00 ctermfg=214
hi tsxAttributeBraces guifg=#FFAF00 ctermfg=214
hi tsxEqual guifg=#FFAF00 ctermfg=214

" Yellow3
hi tsxAttrib guifg=#D7D700 cterm=italic ctermfg=184

" light-grey
hi tsxTypeBraces guifg=#8787AF ctermfg=103

" Grey93

" LightSkyBlue1
hi tsxTypes guifg=#AFD7FF ctermfg=153

" SpringGreen4
hi ReactState guifg=#00875F ctermfg=29
hi ReduxHooksKeywords guifg=#00875F ctermfg=29
hi ReduxKeywords guifg=#00875F ctermfg=29

" SlateBlue1
hi ReactProps guifg=#875FFF ctermfg=99
hi ReactLifeCycleMethods  guifg=#875FFF ctermfg=99

" Honeydew2
hi ApolloGraphQL guifg=#D7FFD7 ctermfg=194

"  IndianRed1
hi Events guifg=#FF5F87 ctermfg=204
hi WebBrowser guifg=#FF5F87 ctermfg=204



