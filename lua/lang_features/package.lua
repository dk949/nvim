local M = {}
local utils = require("utils")

local localRequire = utils.makeLocalRequire "lang_features"
local function combine(...)
    local out = {}
    for _, tbl in ipairs({ ... }) do
        for _, value in ipairs(tbl) do
            table.insert(out, value)
        end
    end

    return out
end

local function uncombine(tbl, ...)
    local args = { ... }
    return vim.tbl_filter(function(x)
        return not vim.tbl_contains(args, x)
    end, tbl)
end

M.allLangs = {}


local function addLangs(feat)
    local get = {}
    if vim.tbl_islist(feat) then
        get = vim.tbl_values
    else
        get = vim.tbl_keys
    end
    for _, l in ipairs(get(feat)) do
        M.allLangs[l] = true
    end
end

local shell = { "csh", "bash", "sh", "tcsh", "zsh" }
local config = { "cabal", "conf", "config", "css", "html", "i3config", "json",
    "jsonc", "kconfig", "ld", "ldapconf", "meson", "modconf", "mysql", "nginx",
    "pamconf", "fstab", "samba", "sass", "sql", "svg", "swayconfig", "systemd",
    "diff", "terminfo", "texinfo", "toml", "viminfo", "xf86conf", "yaml" }
local programming = { "asm", "asm68k", "asm_ca65", "asmh8300", "asterisp",
    "automake", "awk", "b", "basic", "c", "chaiscript", "clojure", "cmake",
    "cobol", "cpp", "cs", "cuda", "d", "dart", "eiffel", "elixir", "elm",
    "erlang", "eruby", "fasm", "forth", "fortran", "freebasic", "go", "groovy",
    "haskell", "j", "java", "javascript", "javascriptreact", "julia", "lex",
    "lisp", "lua", "m4", "make", "nasm", "ninja", "ocaml", "octave", "pascal",
    "perl", "php", "plantuml", "prolog", "ps1", "python", "r", "racket",
    "raku", "ruby", "rust", "scala", "scheme", "scss", "sed", "simula",
    "swift", "tasm", "tcl", "typescript", "typescriptreact", "vim", "vue",
    "yacc", "zig" }
local text = { "autodoc", "bib", "godoc", "groff", "lhaskell", "markdown",
    "plaintex", "rst", "rtf", "tex", "text", "vimwiki",
    "vimwiki_markdown_custom", "todotxt" }
local git = { "git", "gitattributes", "gitcommit", "gitconfig", "gitignore",
    "gitolite", "gitrebase", "gitsendemail" }


M.indent_blankline = combine(shell, config, programming)
-- note indent_blankline does not addLangs because it has no effect in autocmd

M.treesitter = uncombine(
    combine(
        { "comment" }, shell, config, programming, text
    ), "asm", "asm68k", "asm_ca65", "asmh8300", "asterisp", "autodoc", "automake", "b",
    "basic", "bib", "cabal", "chaiscript", "cobol", "conf", "config", "cs", "csh",
    "eiffel", "eruby", "fasm", "forth", "freebasic", "fstab", "godoc", "groff",
    "groovy", "i3config", "j", "javascriptreact", "kconfig", "ld", "ldapconf", "lex",
    "lhaskell", "lisp", "m4", "modconf", "mysql", "nasm", "nginx", "octave", "pamconf",
    "plaintex", "plantuml", "prolog", "ps1", "raku", "rtf", "samba", "sass", "sed", "sh",
    "simula", "svg", "swayconfig", "systemd", "tasm", "tcl", "tcsh", "terminfo", "tex",
    "texinfo", "text", "typescriptreact", "viminfo", "vimwiki",
    "vimwiki_markdown_custom", "xf86conf", "xml", "yacc", "zsh")

-- note treesitter does not addLangs because it has no effect in autocmd

M.spell = combine(text, git)
addLangs(M.spell)

M.wrap = (function()
    local out = {}
    for _, lang in ipairs(text) do
        out[lang] = { "wrap", "linebreak", "nolist", { textwidth = 80 } }
    end
    for _, lang in ipairs(combine(shell, config, programming)) do
        out[lang] = { "nowrap", { textwidth = 110 } }
    end
    return out
end)()
addLangs(M.wrap)

M.formatoptions = (function()
    local out = {}


    --      t   Auto-wrap text using 'textwidth'
    --      q   Allow formatting of comments with "gq".
    --          Note that formatting will not change blank lines or lines containing
    --          only the comment leader.  A new paragraph starts after such a line,
    --          or when the comment leader changes.
    --      n   When formatting text, recognize numbered lists.  This actually uses
    --          the 'formatlistpat' option, thus any kind of list can be used. Note
    --          that 'autoindent' must be set too.
    --      l   Long lines are not broken in insert mode: When a line was longer than
    --          'textwidth' when the insert command started, Vim does not
    --          automatically format it.
    --      1   Don't break a line after a one-letter word.  It's broken before it
    --          instead (if possible).
    --      j   Where it makes sense, remove a comment leader when joining lines.

    for _, lang in ipairs(text) do out[lang] = "tn1" end
    for _, lang in ipairs(combine(shell, config, programming)) do out[lang] = "lqj" end

    return out
end)()
addLangs(M.formatoptions)

M.colorcolumn = combine(shell, config, programming)
addLangs(M.colorcolumn)

M.trailingWS = combine(shell, config, programming, git, text)
addLangs(M.trailingWS)

M.signcolumn = combine(shell, config, programming)
addLangs(M.signcolumn)

M.lspconfig = {
    c       = localRequire "cpp",
    cpp     = localRequire "cpp",
    d       = localRequire "d",
    haskell = localRequire "haskell",
    lua     = localRequire "lua",
}
addLangs(M.lspconfig)

M.fmt = {
    lua = function() vim.lsp.buf.format(); vim.cmd [[:w]] end,
    haskell = function() vim.cmd [[:silent execute "!fourmolu -i %"]] end,
    cpp = function() vim.cmd [[:silent execute "!clang-format --style=file -i %"]] end,
    c = function() vim.cmd [[:silent execute "!clang-format --style=file -i %"]] end,
    d = function() vim.cmd [[:silent execute "!dfmt -i %"]] end,
}
addLangs(M.fmt)

return M
