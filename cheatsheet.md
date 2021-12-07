# Cheatsheet

Note: &lt;leader> = &lt;space>

## `mapmode-n`

| Key chord         | Action                                                              | Mnemonic                       | Context             | location            |
|-------------------|---------------------------------------------------------------------|--------------------------------|---------------------|---------------------|
| `<C-A-h>`         | `:silent call ChangeWindowSize(1,'h')<CR>`                          | (Move window border left)      | Any                 | keymap.vim          |
| `<C-A-j>`         | `:silent call ChangeWindowSize(0,'j')<CR>`                          | (Move window border right)     | Any                 | keymap.vim          |
| `<C-A-k>`         | `:silent call ChangeWindowSize(0,'k')<CR>`                          | (Move window border up)        | Any                 | keymap.vim          |
| `<C-A-l>`         | `:silent call ChangeWindowSize(1,'l')<CR>`                          | (Move window border down)      | Any                 | keymap.vim          |
| `<C-b>`           | `coc#float#has\_scroll() ? coc#float#scroll(0) : "\\<C-b>"`         | (Back?)                        | Coc                 | cocconfig.vim       |
| `<C-f>`           | `coc#float#has\_scroll() ? coc#float#scroll(1) : "\\<C-f>"`         | (Forward?)                     | Coc                 | cocconfig.vim       |
| `<C-h>`           | `<C-w>h`                                                            | (Select left window)           | Any                 | keymap.vim          |
| `<C-j>`           | `<C-w>j`                                                            | (Select right window)          | Any                 | keymap.vim          |
| `<C-k>`           | `<C-w>k`                                                            | (Select top window)            | Any                 | keymap.vim          |
| `<C-l>`           | `<C-w>l`                                                            | (Select bottom window)         | Any                 | keymap.vim          |
| `<C-n>`           | `:New<CR>`                                                          | (New buffer)                   | Any                 | keymap.vim          |
| `<CR>`            | `&buftype ==# 'quickfix' ? ":cc\\<CR>" : "o\\<ESC>"`                | (Enter)                        | quickfix            | keymap.vim          |
| `<CR>`            | `o<esc>`                                                            | (Enter)                        | Any                 | keymap.vim          |
| `<leader>,`       | `:let @/=""<CR>`                                                    | (:man_shrugging:)              | Any                 | keymap.vim          |
| `<leader>;`       | `A;<esc>`                                                           | (;)                            | filetype c,cpp      | cpp.vim             |
| `<leader>;`       | `A;<esc>`                                                           | (;)                            | filetype javascript | jsts.vim            |
| `<leader><space>` | `:call StepOver()<CR>`                                              | (space)                        | filetype c,cpp      | cpp.vim             |
| `<leader>[`       | `A{<CR>}<esc><S-o><esc>`                                            | (shift-{)                      | filetype c,cpp      | cpp.vim             |
| `<leader>[`       | `A{<CR>}<esc><S-o><esc>`                                            | (shift-{)                      | filetype javascript | jsts.vim            |
| `<leader>b`       | `:e#<CR>`                                                           | Back                           | Any                 | keymap.vim          |
| `<leader>ca`      | `<Plug>(coc-codeaction-selected)`                                   | Coc-codeAction-selected        | Coc                 | cocconfig.vim       |
| `<leader>cac`     | `<Plug>(coc-codeaction)`                                            | Coc-Action-Code (?)            | Coc                 | cocconfig.vim       |
| `<leader>ccf`     | `<Plug>(coc-fix-current)`                                           | Coc-Current-Fix                | Coc                 | cocconfig.vim       |
| `<leader>cd`      | `:CocDiagnostics<CR>`                                               | CocDiagnostic                  | Coc                 | cocconfig.vim       |
| `<leader>cdj`     | `<Plug>(coc-diagnostic-next)`                                       | Coc-Diagnostic-                | Coc                 | cocconfig.vim       |
| `<leader>cdk`     | `<Plug>(coc-diagnostic-prev)`                                       | Coc-Diagnostic-                | Coc                 | cocconfig.vim       |
| `<leader>cf`      | `<Plug>(coc-format-selected)`                                       | Coc-Format                     | Coc                 | cocconfig.vim       |
| `<leader>cgd`     | `<Plug>(coc-definition)`                                            | Coc-Goto-Definition            | Coc                 | cocconfig.vim       |
| `<leader>cgi`     | `<Plug>(coc-implementation)`                                        | Coc-Goto-Implementation        | Coc                 | cocconfig.vim       |
| `<leader>cgr`     | `<Plug>(coc-references)`                                            | Coc-Goto-Reference             | Coc                 | cocconfig.vim       |
| `<leader>cgt`     | `<Plug>(coc-type-definition)`                                       | Coc-Goto-Type-definition       | Coc                 | cocconfig.vim       |
| `<leader>crn`     | `<Plug>(coc-rename)`                                                | Coc-Rename                     | Coc                 | cocconfig.vim       |
| `<leader>f`       | `<cmd>lua Ts("builtin")<CR>`                                        | Find                           | Any                 | telescopeconfig.vim |
| `<leader>ff/`     | `<cmd>lua Ts("current*buffer*fuzzy\_find", i)<CR>`                  | Find-File-(search)             | Any                 | telescopeconfig.vim |
| `<leader>ffb`     | `<cmd>lua Ts("buffers", n)<CR>`                                     | Find-File-Buffers              | Any                 | telescopeconfig.vim |
| `<leader>fff`     | `<cmd>lua Ts("find\_files", i)<CR>`                                 | Find-File-Files                | Any                 | telescopeconfig.vim |
| `<leader>ffn`     | `<cmd>lua Ts("file\_browser", n)<CR>`                               | Find-File-NERDTree             | Any                 | telescopeconfig.vim |
| `<leader>ffo`     | `<cmd>lua Ts("oldfiles", n)<CR>`                                    | Find-File-Oldfiles             | Any                 | telescopeconfig.vim |
| `<leader>ffr`     | `<cmd>lua Ts("live\_grep", i)<CR>`                                  | Find-File-Ripgrep              | Any                 | telescopeconfig.vim |
| `<leader>fgb`     | `<cmd>lua Ts("git\_branches", n)<CR>`                               | Find-Git-Branches              | Any                 | telescopeconfig.vim |
| `<leader>fgc`     | `<cmd>lua Ts("git\_commits", n)<CR>`                                | Find-Git-Commits               | Any                 | telescopeconfig.vim |
| `<leader>fgf`     | `<cmd>lua Ts("git\_files", n)<CR>`                                  | Find-Git-Files                 | Any                 | telescopeconfig.vim |
| `<leader>fglb`    | `<cmd>lua Ts("git\_bcommits", n)<CR>`                               | Find-Git-Local(?)-Commits      | Any                 | telescopeconfig.vim |
| `<leader>fgs`     | `<cmd>lua Ts("git\_stash", n)<CR>`                                  | Find-Git-Stash                 | Any                 | telescopeconfig.vim |
| `<leader>fgv`     | `<cmd>lua Ts("git\_status", n)<CR>`                                 | Find-Git-View                  | Any                 | telescopeconfig.vim |
| `<leader>fmj`     | `<cmd>lua Ts("jumplist", n)<CR>`                                    | Find-juMp(?)-Jumplist          | Any                 | telescopeconfig.vim |
| `<leader>fml`     | `<cmd>lua Ts("loclist", n)<CR>`                                     | Find-juMp(?)-Loclist           | Any                 | telescopeconfig.vim |
| `<leader>fmm`     | `<cmd>lua Ts("marks", n)<CR>`                                       | Find-juMp(?)-Marks             | Any                 | telescopeconfig.vim |
| `<leader>fmq`     | `<cmd>lua Ts("quickfix", n)<CR>`                                    | Find-juMp(?)-Quickfix          | Any                 | telescopeconfig.vim |
| `<leader>ftac`    | `<cmd>lua Ts("current\_buffer\_tags", n)<CR>`                       | Find-TAgs-Current-buffer       | Any                 | telescopeconfig.vim |
| `<leader>ftas`    | `<cmd>lua Ts("tagstack", n)<CR>`                                    | Find-TAgs-tagStack             | Any                 | telescopeconfig.vim |
| `<leader>ftat`    | `<cmd>lua Ts("tags", n)<CR>`                                        | Find-TAgs-Tags                 | Any                 | telescopeconfig.vim |
| `<leader>ftl`     | `<cmd>lua Ts("reloader")<CR>`                                       | Find-Telescope-reLoader        | Any                 | telescopeconfig.vim |
| `<leader>ftp`     | `<cmd>lua Ts("pickers", i)<CR>`                                     | Find-Telescope-Pickers         | Any                 | telescopeconfig.vim |
| `<leader>ftr`     | `<cmd>lua Ts("resume")<CR>`                                         | Find-Telescope-Resume          | Any                 | telescopeconfig.vim |
| `<leader>ftup`    | `<cmd>lua Ts("planets")<CR>`                                        | Find-Telescope-Unused-Plannets | Any                 | telescopeconfig.vim |
| `<leader>ful0`    | `<cmd>lua Ts("lsp*code*actions")<CR>`                               | Find-Unused-\*                 | Any                 | telescopeconfig.vim |
| `<leader>ful1`    | `<cmd>lua Ts("lsp\_definitions")<CR>`                               | Find-Unused-\*                 | Any                 | telescopeconfig.vim |
| `<leader>ful2`    | `<cmd>lua Ts("lsp*document*diagnostics")<CR>`                       | Find-Unused-\*                 | Any                 | telescopeconfig.vim |
| `<leader>ful3`    | `<cmd>lua Ts("lsp*document*symbols")<CR>`                           | Find-Unused-\*                 | Any                 | telescopeconfig.vim |
| `<leader>ful4`    | `<cmd>lua Ts("lsp*dynamic*workspace\_symbols")<CR>`                 | Find-Unused-\*                 | Any                 | telescopeconfig.vim |
| `<leader>ful5`    | `<cmd>lua Ts("lsp\_implementations")<CR>`                           | Find-Unused-\*                 | Any                 | telescopeconfig.vim |
| `<leader>ful6`    | `<cmd>lua Ts("lsp*range*code\_actions")<CR>`                        | Find-Unused-\*                 | Any                 | telescopeconfig.vim |
| `<leader>ful7`    | `<cmd>lua Ts("lsp\_references")<CR>`                                | Find-Unused-\*                 | Any                 | telescopeconfig.vim |
| `<leader>ful8`    | `<cmd>lua Ts("lsp*type*definitions")<CR>`                           | Find-Unused-\*                 | Any                 | telescopeconfig.vim |
| `<leader>ful9`    | `<cmd>lua Ts("lsp*workspace*diagnostics")<CR>`                      | Find-Unused-\*                 | Any                 | telescopeconfig.vim |
| `<leader>fulA`    | `<cmd>lua Ts("lsp*workspace*symbols")<CR>`                          | Find-Unused-\*                 | Any                 | telescopeconfig.vim |
| `<leader>fuo0`    | `<cmd>lua Ts("fd", i)<CR>`                                          | Find-Unused-\*                 | Any                 | telescopeconfig.vim |
| `<leader>fuo1`    | `<cmd>lua Ts("symbols")<CR>`                                        | Find-Unused-\*                 | Any                 | telescopeconfig.vim |
| `<leader>fuo2`    | `<cmd>lua Ts("treesitter")<CR>`                                     | Find-Unused-\*                 | Any                 | telescopeconfig.vim |
| `<leader>fva`     | `<cmd>lua Ts("autocommands", n)<CR>`                                | Find-Vim-Autocmd               | Any                 | telescopeconfig.vim |
| `<leader>fvch`    | `<cmd>lua Ts("command\_history", n)<CR>`                            | Find-Vim-Command-History       | Any                 | telescopeconfig.vim |
| `<leader>fvcl`    | `<cmd>lua Ts("colorscheme", n)<CR>`                                 | Find-Vim-CoLorscheme           | Any                 | telescopeconfig.vim |
| `<leader>fvcm`    | `<cmd>lua Ts("commands", n)<CR>`                                    | Find-Vim-CoMmands              | Any                 | telescopeconfig.vim |
| `<leader>fvf`     | `<cmd>lua Ts("filetypes", i)<CR>`                                   | Find-Vim-Filetypes             | Any                 | telescopeconfig.vim |
| `<leader>fvhi`    | `<cmd>lua Ts("highlights", n)<CR>`                                  | Find-Vim-HIghlights            | Any                 | telescopeconfig.vim |
| `<leader>fvhl`    | `<cmd>lua Ts("help\_tags", i)<CR>`                                  | Find-Vim-HeLp                  | Any                 | telescopeconfig.vim |
| `<leader>fvk`     | `<cmd>lua Ts("keymaps", n)<CR>`                                     | Find-Vim-Keymaps               | Any                 | telescopeconfig.vim |
| `<leader>fvo`     | `<cmd>lua Ts("vim\_options", n)<CR>`                                | Find-Vim-Options               | Any                 | telescopeconfig.vim |
| `<leader>fvr`     | `<cmd>lua Ts("registers", n)<CR>`                                   | Find-Vim-Registers             | Any                 | telescopeconfig.vim |
| `<leader>fvsh`    | `<cmd>lua Ts("search\_history", n)<CR>`                             | Find-Vim-Search-History        | Any                 | telescopeconfig.vim |
| `<leader>fvss`    | `<cmd>lua Ts("spell\_suggest", n)<CR>`                              | Find-Vim-Spell-Suggest         | Any                 | telescopeconfig.vim |
| `<leader>ln`      | `:call NextNum()<CR>`                                               | Line-Next                      | Any                 | linecount.vim       |
| `<leader>lz`      | `:call ZeroNum()<CR>`                                               | Line-Zero                      | Any                 | linecount.vim       |
| `<leader>mb`      | `:call gitblame#echo()<CR>`                                         | Make-Blame                     | Any                 | plugins.vim         |
| `<leader>mc`      | `:set cursorline! <CR>`                                             | Make-Cursor                    | Any                 | keymap.vim          |
| `<leader>md`      | `:call StartDoxyComment()<CR>`                                      | Make-Doxygen                   | filetype c,cpp      | doxygen.vim         |
| `<leader>mf`      | `:CMakeFormat<CR>:e<CR>`                                            | Make-Format                    | filetype cmake      | cmake.vim           |
| `<leader>mf`      | `:Format<CR>:e<CR>`                                                 | Make-Format                    | filetype c,cpp      | cpp.vim             |
| `<leader>mf`      | `:Format<CR>:e<CR>`                                                 | Make-Format                    | filetype markdown   | md.vim              |
| `<leader>mf`      | `:Format<CR>:w<CR>:e<CR>`                                           | Make-Format                    | filetype json       | json.vim            |
| `<leader>mf`      | `:Format<CR>:w<CR>:e<CR>`                                           | Make-Format                    | filetype xml        | xml.vim             |
| `<leader>mf`      | `:RustFmt<CR>:w<CR>`                                                | Make-Format                    | filetype rust       | rust.vim            |
| `<leader>mf`      | `<Plug>(coc-format)`                                                | Make-Format                    | filetype haskell    | haskell.vim         |
| `<leader>mf`      | `<Plug>(coc-format)`                                                | Make-Format                    | filetype javascript | jsts.vim            |
| `<leader>mf`      | `<Plug>(coc-format)`                                                | Make-Format                    | filetype python     | python.vim          |
| `<leader>mi`      | `:call <SID>show\_documentation()<CR>`                              | Make-Info(?)                   | Coc                 | cocconfig.vim       |
| `<leader>ml`      | `:Cpplint<CR>`                                                      | Make-Lint                      | filetype c,cpp      | cpp\_lint.vim       |
| `<leader>mm`      | `:call GetManVisual()<CR>`                                          | Make-Man                       | filetype cmake      | cmake.vim           |
| `<leader>ms`      | `:mksession!<CR>`                                                   | Make-Session                   | Any                 | keymap.vim          |
| `<leader>mt`      | `:MakeTerm<CR>`                                                     | Make-Term                      | Any                 | term.vim            |
| `<leader>rg`      | `:Rg`                                                               | RiGrep                         | Any                 | ripgrep.vim         |
| `<leader>t`       | `:tabedit`                                                          | Tabedit                        | Any                 | keymap.vim          |
| `<leader>vg`      | `:WikiGetImage`                                                     | Vimwiki-Get-image              | filetype vimwiki    | vimwikiconfig.vim   |
| `<leader>vi`      | `:WikiInsertImage`                                                  | Vimwiki-Insert-image           | filetype vimwiki    | vimwikiconfig.vim   |
| `<leader>vlm`     | `:call InlineLatexNormal()<CR>`                                     | Vimwiki-Latex-Make             | filetype vimwiki    | vimwikiconfig.vim   |
| `<leader>vlt`     | `:call TextInLatexNormal()<CR>`                                     | Vimwiki-Latex-Text             | filetype javascript | vimwikiconfig.vim   |
| `<leader>x`       | `:call SpaceMode()<CR>`                                             | (:man_shrugging:)              | Any                 | spacemode.vim       |
| `<leader>{`       | `A{<CR>}<esc><S-o>`                                                 | ({)                            | filetype c,cpp      | cpp.vim             |
| `<leader>{`       | `A{<CR>}<esc><S-o>`                                                 | ({)                            | filetype javascript | jsts.vim            |
| `<space>cla`      | `:<C-u>CocList diagnostics<cr>`                                     | Coc-List-diAgnostics           | Coc                 | cocconfig.vim       |
| `<space>clc`      | `:<C-u>CocList commands<cr>`                                        | Coc-List-commands              | Coc                 | cocconfig.vim       |
| `<space>cle`      | `:<C-u>CocList extensions<cr>`                                      | Coc-List-extensions            | Coc                 | cocconfig.vim       |
| `<space>clj`      | `:<C-u>CocNext<CR>`                                                 | Coc-List-(down)                | Coc                 | cocconfig.vim       |
| `<space>clk`      | `:<C-u>CocPrev<CR>`                                                 | Coc-List-(up)                  | Coc                 | cocconfig.vim       |
| `<space>clo`      | `:<C-u>CocList outline<cr>`                                         | Coc-List-Outline               | Coc                 | cocconfig.vim       |
| `<space>clp`      | `:<C-u>CocListResume<CR>`                                           | Coc-List-(:man_shrugging:)     | Coc                 | cocconfig.vim       |
| `<space>cls`      | `:<C-u>CocList -I symbols<cr>`                                      | Coc-List-Synmols               | Coc                 | cocconfig.vim       |
| `Q`               | `<Nop>`                                                             | (nop)                          | Any                 | keymap.vim          |
| `V`               | `v$`                                                                | \(v\)                          | Any                 | keymap.vim          |
| `Y`               | `y$`                                                                | \(y\)                          | Any                 | keymap.vim          |
| `ca0`             | `ca)`                                                               | (ca))                          | Any                 | keymap.vim          |
| `ca9`             | `ca(`                                                               | (ca()                          | Any                 | keymap.vim          |
| `ci0`             | `ci)`                                                               | (ci))                          | Any                 | keymap.vim          |
| `ci9`             | `ci(`                                                               | (ci()                          | Any                 | keymap.vim          |
| `da0`             | `da)`                                                               | (da))                          | Any                 | keymap.vim          |
| `da9`             | `da(`                                                               | (da()                          | Any                 | keymap.vim          |
| `di0`             | `di)`                                                               | (di))                          | Any                 | keymap.vim          |
| `di9`             | `di(`                                                               | (di()                          | Any                 | keymap.vim          |
| `gj`              | `j`                                                                 | \(j\)                          | filetype tex        | tex.vim             |
| `gj`              | `j`                                                                 | \(j\)                          | filetype vimwiki    | vimwikiconfig.vim   |
| `gk`              | `k`                                                                 | \(k\)                          | filetype tex        | tex.vim             |
| `gk`              | `k`                                                                 | \(k\)                          | filetype vimwiki    | vimwikiconfig.vim   |
| `j`               | `&buftype ==# 'quickfix' ? ":cnext\\<CR>:wincmd p\\<CR>" : 'j'`     | \(j\)                          | quickfix            | keymap.vim          |
| `j`               | `gj`                                                                | \(j\)                          | filetype tex        | tex.vim             |
| `j`               | `gj`                                                                | \(j\)                          | filetype vimwiki    | vimwikiconfig.vim   |
| `k`               | `&buftype ==# 'quickfix' ? ":cprevious\\<CR>:wincmd p\\<CR>" : 'k'` | \(k\)                          | quickfix            | keymap.vim          |
| `k`               | `gk`                                                                | \(k\)                          | filetype tex        | tex.vim             |
| `k`               | `gk`                                                                | \(k\)                          | filetype vimwiki    | vimwikiconfig.vim   |
| `vv`              | `V`                                                                 | \(v\)                          | Any                 | keymap.vim          |

## `mapmode-nvo`

| Key chord   | Action                | Mnemonic          | Context | location   |
|-------------|-----------------------|-------------------|---------|------------|
| `<A-h>`     | `:tabNext<CR>`        | (left tab)        | Any     | keymap.vim |
| `<A-l>`     | `:tabnext<CR>`        | (right tab)       | Any     | keymap.vim |
| `<down>`    | `<nop>`               | (nop)             | Any     | keymap.vim |
| `<leader>/` | `<leader>c<space>`    | (:man_shrugging:) | Any     | keymap.vim |
| `<leader>n` | `:NERDTreeToggle<CR>` | Nerdtree          | Any     | keymap.vim |
| `<left>`    | `<nop>`               | (nop)             | Any     | keymap.vim |
| `<right>`   | `<nop>`               | (nop)             | Any     | keymap.vim |
| `<up>`      | `<nop>`               | (nop)             | Any     | keymap.vim |
| `G`         | `Gzz`                 | \(G\)             | Any     | keymap.vim |

## `mapmode-v`

| Key chord     | Action                                                            | Mnemonic           | Context          | location          |
|---------------|-------------------------------------------------------------------|--------------------|------------------|-------------------|
| `<C-C> "*y`   | `:let @+=@*<CR>`                                                  | (ctrl-c)           | Any              | keymap.vim        |
| `<C-b>`       | `coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<C-b>"` | (back)             | Coc              | cocconfig.vim     |
| `<C-f>`       | `coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<C-f>"` | (forward)          | Coc              | cocconfig.vim     |
| `<leader>mm`  | `:call GetManVisual()<CR>`                                        | Make-Man           | Any              | man.vim           |
| `<leader>r`   | `:call RunInReplVisual()<CR>`                                     | Run                | filetype haskell | haskell.vim       |
| `<leader>rg`  | `:call RgVisualSearch()<CR>`                                      | RipGrep            | Any              | ripgrep.vim       |
| `<leader>vlm` | `:call InlineLatexVisual()<CR>`                                   | Vimwiki-Latex-Make | filetype vimwiki | vimwikiconfig.vim |
| `<leader>vlt` | `:call TextInLatexVisual()<CR>`                                   | Vimwiki-Latex-Text | filetype vimwiki | vimwikiconfig.vim |

## `mapmode-x`

| Key chord    | Action                            | Mnemonic            | Context             | location      |
|--------------|-----------------------------------|---------------------|---------------------|---------------|
| `<leader>ca` | `<Plug>(coc-codeaction-selected)` | Coc-Action-selected | Coc                 | cocconfig.vim |
| `<leader>cf` | `<Plug>(coc-format-selected)`     | Coc-Format-selected | Coc                 | cocconfig.vim |
| `<leader>mf` | `<Plug>(coc-format)`              | Make-Format         | filetype haskell    | haskell.vim   |
| `<leader>mf` | `<Plug>(coc-format)`              | Make-Format         | filetype javascript | jsts.vim      |
| `<leader>mf` | `<Plug>(coc-format)`              | Make-Format         | filetype python     | python.vim    |
| `ac`         | `<Plug>(coc-classobj-a)`          | (around class)      | Coc                 | cocconfig.vim |
| `af`         | `<Plug>(coc-funcobj-a)`           | (around function)   | Coc                 | cocconfig.vim |
| `ic`         | `<Plug>(coc-classobj-i)`          | (inside class)      | Coc                 | cocconfig.vim |
| `if`         | `<Plug>(coc-funcobj-i)`           | (inside function)   | Coc                 | cocconfig.vim |

## `mapmode-i`

| Key chord   | Action                                                                            | Mnemonic               | Context | location      |
|-------------|-----------------------------------------------------------------------------------|------------------------|---------|---------------|
| `<C-b>`     | `coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"`          | (back)                 | Coc     | cocconfig.vim |
| `<C-f>`     | `coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"`         | (forward)              | Coc     | cocconfig.vim |
| `<C-h>`     | `<C-\><C-N><C-w>h`                                                                | (Select left window)   | Any     | keymap.vim    |
| `<C-j>`     | `<C-\><C-N><C-w>j`                                                                | (Select right window)  | Any     | keymap.vim    |
| `<C-k>`     | `<C-\><C-N><C-w>k`                                                                | (Select top window)    | Any     | keymap.vim    |
| `<C-l>`     | `<C-\><C-N><C-w>l`                                                                | (Select bottom window) | Any     | keymap.vim    |
| `<F10>`     | `)`                                                                               | ())                    | Any     | keymap.vim    |
| `<F1>`      | `!`                                                                               | (!)                    | Any     | keymap.vim    |
| `<F2>`      | `@`                                                                               | \(@\)                  | Any     | keymap.vim    |
| `<F3>`      | `#`                                                                               | \(#\)                  | Any     | keymap.vim    |
| `<F4>`      | `$`                                                                               | ($)                    | Any     | keymap.vim    |
| `<F5>`      | `%`                                                                               | (%)                    | Any     | keymap.vim    |
| `<F6>`      | `^`                                                                               | (^)                    | Any     | keymap.vim    |
| `<F7>`      | `&`                                                                               | (&)                    | Any     | keymap.vim    |
| `<F8>`      | `*`                                                                               | (\*)                   | Any     | keymap.vim    |
| `<F9>`      | `(`                                                                               | (()                    | Any     | keymap.vim    |
| `<S-TAB>`   | `pumvisible() ? "\<C-p>" : "\<C-h>"`                                              | (reveres tab)          | Coc     | cocconfig.vim |
| `<TAB>`     | `pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()`    | (tab)                  | Coc     | cocconfig.vim |
| `<c-space>` | `coc#refresh()`                                                                   | (:man_shrugging:)      | Coc     | cocconfig.vim |
| `<cr>`      | `pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"` | (enter)                | Coc     | cocconfig.vim |
| `<down>`    | `<nop>`                                                                           | (nop)                  | Any     | keymap.vim    |
| `<left>`    | `<nop>`                                                                           | (nop)                  | Any     | keymap.vim    |
| `<right>`   | `<nop>`                                                                           | (nop)                  | Any     | keymap.vim    |
| `<up>`      | `<nop>`                                                                           | (nop)                  | Any     | keymap.vim    |
