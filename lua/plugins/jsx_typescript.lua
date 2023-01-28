return {
    "peitalin/vim-jsx-typescript",
    -- ft = { "javascriptreact", "typescriptreact" },
    config = function()
        local utils = require("utils")
        -- set colors for tsx highlighting

        -- DeepSkyBlue2
        utils.hi("tsxTagName", { guifg = "#00b2ee", ctermfg = 38 })
        utils.hi("tsxTag", { guifg = "#00b2ee", ctermfg = 38 })
        utils.hi("tsxComponentName", { guifg = "#00b2ee", ctermfg = 38 })
        utils.hi("tsxCloseComponentName", { guifg = "#00b2ee", ctermfg = 38 })
        --
        -- " SteelBlue3
        utils.hi("tsxCloseTagName", { guifg = "#4f94cd", ctermfg = 68 })
        utils.hi("tsxCloseTag", { guifg = "#4f94cd", ctermfg = 68 })
        --
        -- " Orange1
        utils.hi("tsxCloseString", { guifg = "#ffa500", ctermfg = 214 })
        utils.hi("tsxAttributeBraces", { guifg = "#ffa500", ctermfg = 214 })
        utils.hi("tsxEqual", { guifg = "#ffa500", ctermfg = 214 })
        --
        -- " Yellow3
        utils.hi("tsxAttrib", { guifg = "#cdcd00", gui = "italic", cterm = "italic", ctermfg = 184 })
        --
        -- " lightgrey
        utils.hi("tsxTypeBraces", { guifg = "#d3d3d3", ctermfg = 103 })
        --
        -- " LightSkyBlue1
        utils.hi("tsxTypes", { guifg = "#b0e2ff", ctermfg = 153 })
        --
        -- " SpringGreen4
        utils.hi("ReactState", { guifg = "#008b45", ctermfg = 29 })
        utils.hi("ReduxHooksKeywords", { guifg = "#008b45", ctermfg = 29 })
        utils.hi("ReduxKeywords", { guifg = "#008b45", ctermfg = 29 })
        --
        -- " SlateBlue1
        utils.hi("ReactProps", { guifg = "#836fff", ctermfg = 99 })
        utils.hi("ReactLifeCycleMethods", { guifg = "#836fff", ctermfg = 99 })
        --
        -- " Honeydew2
        utils.hi("ApolloGraphQL", { guifg = "#e0eee0", ctermfg = 194 })
        --
        -- "  IndianRed1
        utils.hi("Events", { guifg = "#ff6a6a", ctermfg = 204 })
        utils.hi("WebBrowser", { guifg = "#ff6a6a", ctermfg = 204 })
        --
    end
}
