local keymap = require("config.keymap")
local utils = require("utils")

local current = "dark"
local colorschemes = { dark = "habamax", light = "shine" }
local function invert(col) if col == "dark" then return "light" else return "dark" end end

local tweakTable = {
    light = function()
        local normal = vim.api.nvim_get_hl(0, { name = "Normal", create = false, link = false })
        normal.bg = 0xe8f0f8
        vim.api.nvim_set_hl(0, "Normal", normal)
    end,
    dark = function()
        local lfact = 0x0c141c
        local normal = vim.api.nvim_get_hl(0, { name = "Normal", create = false, link = false })
        local pmenu = vim.api.nvim_get_hl(0, { name = "Pmenu", create = false, link = false })
        local linenr = vim.api.nvim_get_hl(0, { name = "LineNr", create = false, link = false })
        normal.bg = normal.bg + lfact
        pmenu.bg = pmenu.bg + lfact
        linenr.fg = linenr.fg + lfact
        vim.api.nvim_set_hl(0, "Normal", normal)
        vim.api.nvim_set_hl(0, "Pmenu", pmenu)
        vim.api.nvim_set_hl(0, "LineNr", linenr)
    end
}


local function tweaks()
    tweakTable[current]()
    local normal = vim.api.nvim_get_hl(0, { name = "Normal", create = false, link = false })
    local normal_float = vim.api.nvim_get_hl(0, { name = "NormalFloat", create = false, link = false })
    local function_ = vim.api.nvim_get_hl(0, { name = "Function", create = false, link = false })
    vim.api.nvim_set_hl(0, "FloatBorder", normal_float)
    normal_float.bold = true
    vim.api.nvim_set_hl(0, "FloatTitle", normal_float)
    vim.api.nvim_set_hl(0, "ColorColumn", { bg = function_.fg })
    vim.api.nvim_set_hl(0, "NonText", normal)
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
