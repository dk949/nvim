-- https://github.com/"navarasu/onedark.nvim"
return { {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require('onedark').setup {
            -- Main options --
            style = 'dark', -- 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' or 'light'
            transparent = false,
            term_colors = true,
            ending_tildes = false,
            cmp_itemkind_reverse = true,

            toggle_style_key = "<leader>o",
            toggle_style_list = { 'light', 'dark' },


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
            highlights = {
                Title      = { bg = '$bg1' },
                Cursor     = { bg = "$fg", fg = "$bg0", fmt="NONE" },
                SpellBad   = { fg = '$red', fmt = 'underdouble' },
                SpellCap   = { fg = '$cyan' },
                SpellLocal = { fg = "$orange", fmt = 'underline' },
            }, -- Override highlight groups

            diagnostics = {
                darker = true,     -- darker colors for diagnostic
                undercurl = true,  -- use undercurl instead of underline for diagnostics
                background = true, -- use background color for virtual text
            },
        }
        vim.opt.guicursor="n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor,t:block-blinkon500-blinkoff500-TermCursor"
        require('onedark').load()
    end
} }
