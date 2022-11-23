require("utils")
local api = vim.api
-- Map the leader key to space
vim.g.mapleader = dk949.leader

-- Which files are considered code
dk949.codeft = {"ada", "asm", "asm68k", "asm_ca65", "asmh8300", "autohotkey", "automake", "awk", "b", "basic",
"c", "chaiscript", "clean", "clojure", "cmake", "cobol", "cpp", "cs", "csh", "css", "cuda", "d",
"dart", "django", "dockerfile", "dosbatch", "dosini", "doxygen", "eiffel", "elixir", "elm",
"erlang", "fasm", "forth", "fortran", "freebasic", "gdscript", "gdshader", "go", "groovy",
"haml", "haskell", "html", "j", "java", "javascript", "javascriptreact", "json", "jsonc",
"julia", "lisp", "lua", "m4", "make", "masm", "meson", "modula2", "modula3", "nasm", "ninja",
"objc", "objcpp", "ocaml", "octave", "pascal", "perl", "php", "prolog", "ps1", "python", "r",
"racket", "raku", "ruby", "rust", "sass", "scala", "scheme", "sh", "simula", "sql", "svg",
"swift", "tcl", "tcsh", "vhdl", "vim", "vue", "yacc", "yaml", "zsh", "zig"}

dk949.noncodeft = {"markdown", "tex", "plaintex", "vimwiki"}

-- Turning on the filetype plugin
vim.cmd[[filetype plugin on]]
vim.cmd[[filetype plugin indent on]]

-- Hybrid numbering in normal mode and normal numbering in insert mode
local relNum = setter {relativenumber = true, number = true}
local noRelNum = setter {relativenumber = false, number = true}
augroup("NumberGroup", {
    InsertLeave = {callback = relNum},
    InsertEnter = {callback = setter {relativenumber = false}},
})
relNum()

--  Terminal stuff
augroup("TerminalGroup", {
    TermOpen = {callback = setter {relativenumber = false, number = false}},
    [{"BufWinEnter","WinEnter"}] = {pattern = "term://*", command = "startinsert"}
})

-- Remove unnecessary auto formatting
augroup("FormatOptsGroup", {
    BufEnter = { callback = function() vim.opt.formatoptions:remove({'c','r','o', 't'}) end}
})

-- No whitespace at the ned of lines
augroup("NoTrailingSpacesGroup", {
    BufWritePre = {command = [[%s/\s\+$//e]]},
})

augroup("RememberFileGroup", {
    [{"VimLeave", "BufLeave"}] = {callback = function() if dk949.nomkview then dk949.nomkview = false else vim.cmd[[silent! mkview]]end end},
    [{"VimEnter", "BufEnter"}] = {command = [[silent! loadview]]}
})

-- setting tabsize
vim.opt.tabstop = dk949.tabstop
vim.opt.shiftwidth = dk949.tabstop
vim.opt.softtabstop = dk949.tabstop
vim.opt.expandtab = true

-- When searching with only lowercase letters, case will be ignored. Not ignored with capitals.
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Incremental search and no highlighting
vim.opt.incsearch = true
vim.opt.hlsearch = false

-- Search through subdirectories recursively
vim.opt.path:append("**")

-- Spilts act as expected
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Mouse
vim.opt.mouse = dk949.mouse
