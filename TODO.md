# TODO

## Features not yet ported from original config

Listed in alphabetical order (roughly)

* [X] ALE
* [X] detect `*.asm` as nasm files
* [X] cc65 support
* [X] Cmake
    * [X] Formatting
* [X] C++
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
* [X] Go
    * [X] Formatting
* [ ] Haskell
    * [X] Formatting
    * [ ] REPL (See below)
* [X] Hexedit
    * [X] use `xxd` to edit binary files
* [X] HTML
    * [X] Formatting
* [X] JSON
    * [X] Formatting
* [X] Javascript/Typescript
    * [X] Formatting (LSP powered)
* [X] Look
    * [X] powerline/tabline: covered by lualine
    * [X] Theme covered by `onedark`
    * [X] JSX custom colors
* [X] Make
    * [X] Formatting
* [X] Man
    * Covered by `<C-k>`
* [X] Markdown
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
* [X] rust
    * [X] Formatting
* [X] snippets
    * Replaced by the `file_templates` system
* [X] `telescopeconfig`
* [X] term
* [X] tex
    * [X] Logical line movement
    * [X] Spelling
    * [X] Auto compilation
* [X] `vimwikiconfig`
* [X] xml
    * [X] Formatting
* [X] Zig
    * [X] Formatting

* [X] Plugins
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
* [X] LSP
    * [X] `ccls`
    * [X] `cssls`
    * [X] `tailwindcss`
    * [X] `elmLS`
    * [X] `eslint`
    * [X] `gopls`
    * [X] `hls`
    * [X] `html`
    * [X] `pyright`
    * [X] `rust_analyzer`
    * [X] `serve-d`
    * [X] `tsserver`
    * [X] `zls`

## Planned fixes and features

* [ ] REPL shell for languages that have a REPL.
* [ ] Fix markdown
  * [ ] formatting
* [ ] Disable spell check in the terminal
