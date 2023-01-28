return {
    "peitalin/vim-jsx-typescript",
    -- ft = { "javascriptreact", "typescriptreact" },
    config = function()
        local utils = require("utils")
        -- set colors for tsx highlighting

        -- " SteelBlue3
        utils.hi("tsxCloseTagName", { guifg = "#4f94cd", ctermfg = 68 })
        utils.hi("tsxCloseTag", { guifg = "#4f94cd", ctermfg = 68 })
        --
        -- " Orange1
        utils.hi("tsxCloseString", { guifg = "#ffa500", ctermfg = 214 })
        utils.hi("tsxAttributeBraces", { guifg = "#ffa500", ctermfg = 214 })
        utils.hi("tsxEqual", { guifg = "#ffa500", ctermfg = 214 })
        --
        --        -- " lightgrey
        utils.hi("tsxTypeBraces", { guifg = "#d3d3d3", ctermfg = 103 })
        --
        -- " LightSkyBlue1
        utils.hi("tsxTypes", { guifg = "#b0e2ff", ctermfg = 153 })
        --
    end
}
