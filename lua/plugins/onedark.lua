-- https://github.com/"navarasu/onedark.nvim"
return {
    "navarasu/onedark.nvim",
    config = function()
        require('onedark').setup {
            -- Main options --
            style = 'dark', -- 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' or 'light'
            transparent = false,
            term_colors = true,
            ending_tildes = false,
            cmp_itemkind_reverse = true,


            -- italic, bold, underline, none
            -- or any combination e.g. 'italic,bold'
            code_style = {
                comments  = 'none',
                keywords  = 'none',
                functions = 'none',
                strings   = 'none',
                variables = 'none'
            },

            lualine = {
                transparent = false, -- lualine center bar transparency
            },

            colors = {}, -- Override default colors
            highlights = {}, -- Override highlight groups

            diagnostics = {
                darker = true, -- darker colors for diagnostic
                undercurl = true, -- use undercurl instead of underline for diagnostics
                background = true, -- use background color for virtual text
            },
        }
        require('onedark').load()
    end
}
