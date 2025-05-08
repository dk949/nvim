-- https://github.com/SmiteshP/nvim-navic

local ft = vim.tbl_keys(require("lang_features").feat.lspconfig)
return { {
    "SmiteshP/nvim-navic",
    ft = ft,
    opts = {
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
} }
