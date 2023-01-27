# TODO

## Features not yet ported from original config

Listed in alphabetical order (roughly)

* [ ] ALE
* [X] detect `*.asm` as nasm files
* [ ] cc65 support
* [ ] Cmake
    * [X] Formatting
    * [ ] `GetManVisual` function
* [ ] LSP
    * [X] `ccls`
    * [X] `cssls`
    * [ ] `tailwindcss`
    * [ ] `elmLS`
    * [ ] `eslint`
    * [ ] `gopls`
    * [X] `hls`
    * [X] `html`
    * [ ] `purescriptls`
    * [X] `pyright`
    * [ ] `ruby_ls`
    * [X] `rust_analyzer`
    * [X] `serve-d`
    * [ ] `tsserver`
    * [X] `zls`
* [ ] C++
    * [ ] Various outdated shortcuts which will probably not be ported
    * [ ] Linting setup
    * [X] Formatting
* [X] CSS
    * [X] Formatting
* [X] D
    * [X] Formatting
    * [X] make = dub and errorformat
    * [X] Dutyl
* [ ] Doxygen
    * [ ] `StartDoxyComment` function
* [ ] Elm
    * [ ] Formatting (LSP powered)
* [X] Git
    * Note: Whilst most of the old functionality was not ported, it is covered
        by `Gitsigns`
* [X] Git Blame
    * See above
* [ ] Go
    * [ ] Formatting
* [ ] Haskell
    * [X] Formatting
    * [ ] REPL (See below)
* [ ] Hexedit
    * [ ] use `xxd` to edit binary files
    * [ ] Decode selected regions as ascii or decimals
* [X] HTML
    * [X] Formatting
* [X] JSON
    * [X] Formatting
* [ ] Javascript/Typescript
    * [ ] Formatting (LSP powered)
    * [ ] Some way to set tabstop based on project(?)
* [ ] Line count
    * [ ] No longer in use
* [ ] Look
    * [X] powerline/tabline: covered by lualine
    * [X] Theme covered by `onedark`
    * [ ] Semshi custom colors, will port if using semshi (which is unlikely)
    * [ ] JSX custom colors
* [X] Make
    * [X] Formatting
* [X] Man
    * Covered by `<C-k>`
* [ ] Maths
    * [ ] Replace visual selection with the result of the calculation
        * Note: It never worked in the first place
* [ ] Markdown
    * [ ] Formatting
    * [X] Logical line movement
    * [X] Spelling
* [X] PDF
    * Migrated to <https://github.com/dk949/pdf.vim>
* [X] print_file
    * [X] `PrintFileFullName`
    * [X] `PrintFileName`
    * [X] `PrintFileDirAbs`
    * [X] `PrintFileDirRel`
* [X] Python
    * [X] Formatting
* [ ] `ripgrep`
    * Replaced by Telescope
* [ ] `roc`
    * Need to check if there is vim support
* [ ] ruby
    * [ ] Formatting
* [X] rust
    * [X] Formatting
* [X] snippets
    * Replaced by the `file_templates` system
* [ ] `spacemode`
    * was not being used
* [X] `telescopeconfig`
* [X] term
* [ ] tex
    * [X] Logical line movement
    * [X] Spelling
    * [ ] Auto compilation
* [X] `vimwikiconfig`
* [X] xml
    * [X] Formatting
* [X] Zig
    * [X] Formatting

* [ ] Plugins
    * [X] Powerline/theme
        * See `look`
    * [X] `Nerdtree`
        * Replaced by `Tree.nvim`
    * [X] `Netdcommenter`
        * Replaced by `Comment`
    * [X] `vim-surround`
    * [X] `vimwiki`
    * [X] `coc`
        * Replaced by lspconfig
    * [X] `vim-lsp-cxx-highlight`
    * [ ] `syntastic_cpp` - Discontinued, will not be ported (unless someone forks it)
    * [X] `dutyl`
    * [ ] `pegged.vim`
        * Will be installed if I ever need it again
    * [ ] `ale`
        * See `ale`
    * [X] `haskell-vim`
    * [ ] `typescript-vim`
    * [ ] `vim-jsx-typescript`
    * [ ] `vim-node-inspect1`
    * [X] `vim-highlightedyank`
    * [X] `plantuml-syntax`
    * [X] `rust.vim`
    * [X] `git-blame.vim`
        * Replaced by `Gitsigns`
    * [ ] `vim-asm_ca65`
    * [X] `tabular`
    * [X] `vim-markdown`
    * [X] `zig`
    * [ ] `purescript-vim`
    * [ ] `dhall-vim`
    * [X] `plenary.nvim`
    * [X] `telescope.nvim`
    * [X] `minimap.vim`
    * [ ] `fluent`

## Planned fixes and features

* [ ] REPL shell for languages that have a REPL.
* [ ] Fix markdown
  * [ ] formatting
* [ ] Disable spell check in the terminal
