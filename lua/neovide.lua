if not vim.g.neovide then return end
local utils = require("utils");



-- Keys

vim.keymap.set({ 'n', 'v', 'o' }, "<C-S-v>", '"+p')
vim.keymap.set({ 'i', 'c', 't' }, "<C-S-v>", '<C-O>"+p')

vim.keymap.set({ 'n', 'v', 'o', 'i', 'c', 't' }, "<RightMouse>", "<nop>")
vim.keymap.set({ 'n', 'v', 'o', 'i', 'c', 't' }, "<LeftMouse>", "<nop>")
vim.keymap.set({ 'n', 'v', 'o', 'i', 'c', 't' }, "<2-LeftMouse>", "<nop>")
vim.keymap.set({ 'n', 'v', 'o', 'i', 'c', 't' }, "<3-LeftMouse>", "<nop>")
vim.keymap.set({ 'n', 'v', 'o', 'i', 'c', 't' }, "<4-LeftMouse>", "<nop>")

vim.opt.mouse = "a"
vim.opt.mousemodel = "popup"


-- scale
local scale_default = 1.0
local max_scale = 2.5
local min_scale = 0.3
local scale_dif = 0.05

local function scaleChange(dir)
    local new_scale
    if dir == 0 then
        new_scale = scale_default
    else
        new_scale = vim.g.neovide_scale_factor + (scale_dif * dir)
    end
    vim.g.neovide_scale_factor = utils.clamp(min_scale, new_scale, max_scale)
end

vim.keymap.set("n", "<C-=>", function() scaleChange(0) end)
vim.keymap.set("n", "<C-+>", function() scaleChange(1) end)
vim.keymap.set("n", "<C-->", function() scaleChange(-1) end)
vim.g.neovide_scale_factor = scale_default


-- animations

vim.g.neovide_scroll_animation_length = 0.05
vim.g.neovide_scroll_animation_far_lines = 100
vim.g.neovide_cursor_animation_length = 0.00
vim.g.neovide_cursor_trail_size = 0
vim.g.neovide_cursor_animate_in_insert_mode = false
vim.g.neovide_cursor_animate_command_line = false

-- cursor look

vim.g.neovide_cursor_antialiasing = true
vim.g.neovide_cursor_unfocused_outline_width = 0.06

-- transparancy

vim.opt.winblend = 30
