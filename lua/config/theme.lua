local keymap = require("config.keymap")
local utils = require("utils")

utils.withAugroup("color", function(grp)
    vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
            local normal_float = vim.api.nvim_get_hl(0, { name = "NormalFloat", create = false, link = false })
            vim.api.nvim_set_hl(0, "FloatBorder", normal_float)
            normal_float.bold = true
            vim.api.nvim_set_hl(0, "FloatTitle", normal_float)
        end
    })
end)

local colorschemes = {
    dark = "habamax",
    light = "zellner",
}
local current = "dark"

local function invert(col)
    if col == "dark" then return "light" else return "dark" end
end

vim.cmd.colorscheme(colorschemes[current])

keymap.color:defaultApply { colortoggle = function()
    current = invert(current)
    vim.cmd.colorscheme(colorschemes[current])
end }

-- vim.cmd [[highlight ColorColumn ctermbg=11 guibg=#3c73c3]]
vim.api.nvim_set_hl(0, "ColorColumn", {
    bg = vim.api.nvim_get_hl(0, { name = "Function", create = false, link = false }).fg
})

vim.opt.fillchars:append({ eob = " " })
vim.opt.guicursor =
"n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor,t:block-blinkon500-blinkoff500-TermCursor"
