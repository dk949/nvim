-- https://github.com/SmiteshP/nvim-navic
return {
    -- "SmiteshP/nvim-navic",
    "~/code/vim/nvim-navic",
    config = function()
        require("nvim-navic").setup {
            icons = {
                File          = ' ',
                Module        = ' ',
                Namespace     = ' ',
                Package       = ' ',
                Class         = ' ',
                Method        = ' ',
                Property      = ' ',
                Field         = ' ',
                Constructor   = ' ',
                Enum          = ' ',
                Interface     = ' ',
                Function      = ' ',
                Variable      = ' ',
                Constant      = ' ',
                String        = ' ',
                Number        = ' ',
                Boolean       = ' ',
                Array         = ' ',
                Object        = ' ',
                Key           = ' ',
                Null          = ' ',
                EnumMember    = ' ',
                Struct        = ' ',
                Event         = ' ',
                Operator      = ' ',
                TypeParameter = ' '
            },
            separator = " > ",
            highlight = false,
            depth_limit = 3,
        }
    end
}
