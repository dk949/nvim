-- Quick settings
_G.dk949 = {
    leader = " ",
    tabstop = 4,
    mouse = "",
    arrows = false,
    winSzInc = 5,
}

local simple = require('simple')
if simple.isRoot() then return simple.source() end

require('core')
require('keymap')
require('commands')
require('plugins')
require('lang_features').setup()
require('file_templates')
