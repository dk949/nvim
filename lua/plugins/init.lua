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
    localUse "oil"
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
    localUse "flatten"

    -- telescope
    localUse "plenary"
    localUse "telescope"

    -- Lsp
    localRequire "lsp" ()

    -- Treesitter
    localUse "treesitter"

    -- ALE
    localUse "ale"

    -- debugging
    localUse "vimspector"

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
    use { '~/code/python/scotch/tools/vim/scot/' }
    localUse "obsidian"
    localUse "file_line"
    localUse "serve_d_utils"
    localUse "remember-where"
    localUse "repl"
    localUse "copilot"
end)
