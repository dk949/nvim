local M = {}
local utils = require("utils")

local localRequire = utils.makeLocalRequire "lang_features"

local function combineLSPs(...)
    local args = { ... }
    local lspConfigs = {}
    local lspNames = {}
    for _, lsp in ipairs(args) do
        local loaded = localRequire(lsp)
        table.insert(lspConfigs, loaded.server)
        table.insert(lspNames, loaded.masonInstall)
    end
    return {
        server = function(capabilities, on_attach)
            for _, lsp in ipairs(lspConfigs) do
                lsp(capabilities, on_attach)
            end
        end,
        masonInstall = lspNames,
    }
end

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
    local get = nil
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
local config = { "bib", "cabal", "conf", "config", "css", "diff", "fstab",
    "html", "i3config", "json", "jsonc", "kconfig", "ld", "ldapconf", "meson",
    "modconf", "mysql", "nginx", "pamconf", "samba", "sass", "sql", "svg",
    "swayconfig", "systemd", "terminfo", "texinfo", "text", "todotxt", "toml",
    "viminfo", "xf86conf", "yaml" }
local programming = { "asm", "asm68k", "asm_ca65", "asmh8300", "asterisp",
    "automake", "awk", "b", "basic", "c", "chaiscript", "clojure", "cmake",
    "cobol", "cpp", "cs", "cuda", "d", "dart", "eiffel", "elixir", "elm",
    "erlang", "eruby", "fasm", "forth", "fortran", "freebasic", "go", "groovy",
    "haskell", "j", "java", "javascript", "javascriptreact", "julia", "kotlin",
    "lex", "lisp", "lua", "m4", "make", "nasm", "ninja", "nix", "ocaml",
    "octave", "pascal", "perl", "php", "plantuml", "prolog", "ps1", "python",
    "r", "racket", "raku", "ruby", "rust", "scala", "scheme", "scss", "sed",
    "simula", "swift", "tasm", "tcl", "typescript", "typescriptreact", "vim",
    "vue", "yacc", "zig" }
local text = { "autodoc", "godoc", "groff", "lhaskell", "markdown", "plaintex",
    "rst", "rtf", "tex", "vimwiki", "vimwiki_markdown_custom" }
local git = { "git", "gitattributes", "gitcommit", "gitconfig", "gitignore",
    "gitolite", "gitrebase", "gitsendemail" }

addLangs(shell)
addLangs(config)
addLangs(programming)
addLangs(text)
addLangs(git)

M.goyo_mode = { "tex", "plaintex", "markdown" }

M.indent_blankline = combine(shell, config, programming)

M.treesitter = uncombine(
    combine(
        { "comment" }, shell, config, programming, text
    ),
    -- Unuspported
    "asm", "asm68k", "asm_ca65", "asmh8300", "asterisp", "autodoc", "automake", "b",
    "basic", "bib", "cabal", "chaiscript", "cobol", "conf", "config", "cs", "csh",
    "eiffel", "eruby", "fasm", "forth", "freebasic", "fstab", "godoc", "groff",
    "groovy", "i3config", "j", "javascriptreact", "kconfig", "ld", "ldapconf", "lex",
    "lhaskell", "lisp", "m4", "modconf", "mysql", "nasm", "nginx", "octave", "pamconf",
    "plaintex", "plantuml", "prolog", "ps1", "raku", "rtf", "samba", "sass", "sed", "sh",
    "simula", "svg", "swayconfig", "systemd", "tasm", "tcl", "tcsh", "terminfo", "tex",
    "texinfo", "text", "typescriptreact", "viminfo", "vimwiki",
    "vimwiki_markdown_custom", "xf86conf", "yacc", "zsh",
    -- Supported but manually disabled
    "markdown", "haskell", "bash")


M.spell = combine(text, git, { "bib", "todotxt", "text" })

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

M.tab = {
    markdown = { len = 2, expand = true },
    html     = { len = 2, expand = true },
    make     = { len = 4, expand = false },
}

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
    --      a   Automatic formatting of paragraphs.  Every time text is inserted or
    --          deleted the paragraph will be reformatted.  See |auto-format|.
    --          When the 'c' flag is present this only happens for recognized
    --          comments.

    for _, lang in ipairs(text) do out[lang] = "atn1" end
    for _, lang in ipairs(combine(shell, config, programming)) do out[lang] = "lqj" end

    return out
end)()

M.colorcolumn = combine(shell, config, programming)

M.trailingWS = combine(shell, config, programming, git, text)

M.signcolumn = combine(shell, config, programming)

M.logicalLines = combine(git, text)

local lspSetups = {
    c               = combineLSPs "ccls",
    cmake           = combineLSPs "cmake",
    cpp             = combineLSPs "ccls",
    css             = combineLSPs("cssls", "tailwindcss"),
    cuda            = combineLSPs "ccls",
    d               = combineLSPs "serve_d",
    elm             = combineLSPs "elmls",
    fortran         = combineLSPs "fortls",
    go              = combineLSPs "gopls",
    haskell         = combineLSPs "hls",
    html            = combineLSPs "html",
    javascript      = combineLSPs("eslint", "tsserver", "tailwindcss"),
    javascriptreact = combineLSPs("eslint", "tsserver", "tailwindcss"),
    less            = combineLSPs("cssls", "tailwindcss"),
    lua             = combineLSPs "lua_ls",
    nix             = combineLSPs "nil_ls",
    python          = combineLSPs "pyright",
    rust            = combineLSPs "rust_analyzer",
    scss            = combineLSPs("cssls", "tailwindcss"),
    typescript      = combineLSPs("eslint", "tsserver", "tailwindcss"),
    typescriptreact = combineLSPs("eslint", "tsserver", "tailwindcss"),
    zig             = combineLSPs "zls",
}
M.lspservers = {}
M.lspconfig = {}
for lang, lsp in pairs(lspSetups) do
    M.lspconfig[lang] = lsp.server
    table.insert(M.lspservers, lsp.masonInstall)
end
M.lspservers = utils.unique(vim.tbl_flatten(M.lspservers))

local fmtRun = function(cmd) return utils.shRun(cmd, { runner = "bang", silent = true }) end
local mggg = function() vim.api.nvim_feedkeys([[mggg=G`g]], "", true) end
local lspFmt = function()
    vim.lsp.buf.format(); vim.cmd [[:w]]
end
M.fmt = {
    c = function() fmtRun [[clang-format --style=file -i %]] end,
    cmake = function() fmtRun [[cmake-format -i %]] end,
    cpp = function() fmtRun [[clang-format --style=file -i %]] end,
    css = mggg,
    cuda = function() fmtRun [[clang-format --style=file -i %]] end,
    d = function() fmtRun [[dfmt -i %]] end,
    fortran = lspFmt,
    haskell = function() fmtRun [[fourmolu -i %]] end,
    html = lspFmt,
    javascript = lspFmt,
    javascriptreact = lspFmt,
    json = function() vim.cmd [[silent execute "%!jq ."]] end,
    lua = lspFmt,
    make = mggg,
    python = function() fmtRun [[autopep8 -i %]] end,
    rust = function()
        vim.cmd [[RustFmt]]; vim.cmd [[:w]]
    end,
    typescript = lspFmt,
    typescriptreact = lspFmt,
    xml = function() vim.cmd [[silent execute "%!xmllint --format -"]] end,
    zig = function() fmtRun [[zig fmt %]] end,
}

return M
