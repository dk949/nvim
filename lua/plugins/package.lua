local fn = vim.fn
local fs = vim.fs
local utils = require("utils")
local localRequire = utils.makeLocalRequire [[plugins]]
local localUse = function(plug) return require("packer").use(localRequire(plug)) end

localRequire("ensurePakcer")()

return require("packer").startup(function()
    --Packer
    localUse "packer"

    -- statusline
    localUse "lualine"
    localUse "navic"

    -- Themes
    localUse "dracula"
    localUse "onedark"

    -- QoL
    localUse "highlightedyank"
    localUse "Comment"
    localUse "tree"
    localUse "surround"
    localUse "gitsigns"
    localUse "tabular"
    localUse "minimap"
    localUse "indent_blankline"
    localUse "termutils"
    localUse "emmet"

    -- telescope
    localUse "plenary"
    localUse "telescope"

    -- Lsp
    localRequire "lsp" ()

    -- Treesitter
    localUse "treesitter"

    -- ALE
    localUse "ale"

    -- Language support
    localUse "plantuml"
    localUse "asm_ca65"
    localUse "markdown"
    localUse "zig"
    localUse "rust"
    localUse "llvm"
    localUse "haskell"
    localUse "jsx_typescript"
    localUse "typescript"
    localUse "dutyl"
    localUse "todotxt"
    localUse "pdf"
    use { '~/code/vim/asterisp.vim' }

    -- Misc
    localUse "vimwiki"

end)
