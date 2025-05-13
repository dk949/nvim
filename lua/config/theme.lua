local keymap = require("config.keymap")
local colorscheme = {
    dark = "habamax",
    light = "zellner",
}
local current = "dark"

local function invert(col)
    if col == "dark" then return "light" else return "dark" end
end


vim.cmd.colorscheme("habamax")
vim.opt.guicursor =
"n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor,t:block-blinkon500-blinkoff500-TermCursor"

vim.opt.fillchars:append({ eob = " " })
keymap.color:defaultApply { colortoggle = function()
    current = invert(current)
    vim.cmd.colorscheme(colorscheme[current])
end }
