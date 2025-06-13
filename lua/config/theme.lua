local keymap = require("config.keymap")
local utils = require("utils")

local current = "dark"
local colorschemes = { dark = "habamax", light = "zellner" }
local function invert(col) if col == "dark" then return "light" else return "dark" end end

local tweakTable = {
    light = function() end,
    dark = function() end
}

local function tweaks()
    local normal_float = vim.api.nvim_get_hl(0, { name = "NormalFloat", create = false, link = false })
    vim.api.nvim_set_hl(0, "FloatBorder", normal_float)
    normal_float.bold = true
    vim.api.nvim_set_hl(0, "FloatTitle", normal_float)
    vim.api.nvim_set_hl(0, "ColorColumn", {
        bg = vim.api.nvim_get_hl(0, { name = "Function", create = false, link = false }).fg
    })
    tweakTable[current]()
end

utils.withAugroup("color", function(grp)
    vim.api.nvim_create_autocmd("ColorScheme", {
        callback = tweaks,
        group = grp,
    })
end)

vim.cmd.colorscheme(colorschemes[current])

keymap.color:defaultApply { colortoggle = function()
    current = invert(current)
    vim.cmd.colorscheme(colorschemes[current])
end }

vim.opt.fillchars:append({ eob = " " })
vim.opt.guicursor =
"n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor,t:block-blinkon500-blinkoff500-TermCursor"
