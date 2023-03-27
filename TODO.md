# TODO

## Features not yet ported from original config

Listed in alphabetical order (roughly)

* [X] ALE
* [X] detect `*.asm` as nasm files
* [X] cc65 support
* [X] Cmake
    * [X] Formatting
* [ ] C++
    * [ ] Linting setup
    * [X] Formatting
    * [ ] Various outdated shortcuts which will probably not be ported
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
    * No longer in use
* [X] Look
    * [X] powerline/tabline: covered by lualine
    * [X] Theme covered by `onedark`
    * [X] JSX custom colors
    * [ ] Semshi custom colors
      * will port if using semshi (which is unlikely)
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
* [X] `ripgrep`
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
    * [X] `vim-surround`
    * [X] `vimwiki`
    * [X] `vim-lsp-cxx-highlight`
    * [X] `dutyl`
    * [X] `ale`
    * [X] `haskell-vim`
    * [X] `typescript-vim`
    * [X] `vim-jsx-typescript`
    * [X] `vim-highlightedyank`
    * [X] `plantuml-syntax`
    * [X] `rust.vim`
    * [X] `vim-asm_ca65`
    * [X] `tabular`
    * [X] `vim-markdown`
    * [X] `zig`
    * [X] `plenary.nvim`
    * [X] `telescope.nvim`
    * [X] `minimap.vim`
* [ ] LSP
    * [X] `ccls`
    * [X] `cssls`
    * [X] `tailwindcss`
    * [ ] `elmLS`
    * [X] `eslint`
    * [ ] `gopls`
    * [X] `hls`
    * [X] `html`
    * [ ] `purescriptls`
    * [X] `pyright`
    * [ ] `ruby_ls`
    * [X] `rust_analyzer`
    * [X] `serve-d`
    * [X] `tsserver`
    * [X] `zls`

## Planned fixes and features

* [ ] REPL shell for languages that have a REPL.
* [ ] Fix markdown
  * [ ] formatting
* [ ] Disable spell check in the terminal
