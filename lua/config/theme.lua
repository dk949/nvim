local keymap = require("config.keymap")
local utils = require("utils")

local current = "dark"
local function invert(col) if col == "dark" then return "light" else return "dark" end end

local M = {}

function M.toggle()
    current = invert(current)
    vim.o.background = current
    -- vim.cmd.colorscheme("onedark")
end

M.style = "warm"

function M.setup()
    keymap.color:defaultApply { colortoggle = M.toggle }

    -- vim.opt.fillchars:append({ eob = " " })
    vim.o.background = current
    vim.cmd.colorscheme("onedark")
    vim.opt.guicursor = "n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor,t:block-blinkon500-blinkoff500-TermCursor"
end

return M
