-- Quick settings
_G.dk949 = {
    load_start = vim.fn.reltime(),
    leader = " ",
    tabstop = 4,
    mouse = "",
    arrows = false,
    winSzInc = 5,
    obsidian_worspaces = { { name = "wiki", path = "~/Uni/wiki" } },
}

local simple = require('simple')
if simple.isRoot() then return simple.source() end

require('core')
require('keymap')
require('neovide')
require('commands')
require('plugins')
require('lang_features').setup()
require('file_templates')
