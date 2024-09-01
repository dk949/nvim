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
    localUse "goyo"
    localUse "dispatch"
    localUse "icon_picker"
    localUse "dressing"
    localUse "color"
    localUse "bullets"

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
    localUse "asm_ca65"
    localUse "dutyl"
    localUse "haskell"
    localUse "jsx_typescript"
    localUse "llvm"
    localUse "pdf"
    localUse "plantuml"
    localUse "rust"
    localUse "typescript"
    localUse "glsl"
    localUse "pegged"
    localUse "lark"
    use { '~/code/vim/asterisp.vim' }
    localUse "obsidian"

end)
