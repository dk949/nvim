require("misc.utils")
local k = vim.keymap
local function desc(msg) return {desc = msg, silent = true} end
local function edesc(msg) return {desc = msg, silent = true, expr = true} end

-- Map the leader key to space
vim.g.mapleader = " "

-- General fixes
k.set('n', "G", "Gzz", desc"jump to line centers the screen on that line")

k.set('v', "<C-C>", [["*y :let @+=@*<CR>]], desc[[ctrl-c to copy]])

k.set('n', "vv", "V", desc[[vv to select whole line]])

k.set('n', "V", "v$", desc[[V to select until the end of the line]])

k.set('n', "Y", "y$", desc[[Y to yank until the end of the line]])

k.set('t', "<C-[><C-[>", [[<C-\><C-n>]], desc[[Double escape to get to normal mode in terminal mode]])

k.set('n', "<C-l>", ":mode<CR>", desc[[redraw the screen on ctrl-l]])

k.set({'n', 'i'}, "<A-l>", "gt", desc[[alt-l for next tab]])
k.set({'n', 'i'}, "<A-h>", "gT", desc[[alt-h for prev tab]])

for _, dir in ipairs{'h', 'j', 'k', 'l'} do
    k.set({'i', 't'}, "<C-"..dir..">",[[<C-\><C-N><C-w>]]..dir, desc("use ctrl-"..dir.." to move between windows in insert and terminal modes"))
    k.set('n', "<C-"..dir..">","<C-w>"..dir, desc("use ctrl-"..dir.." to move between windows in normal mode"))
end

k.set('n', "j",    function() return (vim.bo.buftype == "quickfix") and ":cnext<CR>:wincmd p<CR>" or 'j'    end , edesc[[j moves to next quickfix]])
k.set('n', "k",    function() return (vim.bo.buftype == "quickfix") and ":cprevious<CR>:wincmd p<CR>" or 'k'end , edesc[[k moves to prev quickfix]])
k.set('n', "<CR>", function() return (vim.bo.buftype == "quickfix") and ":cc<CR>" or '<CR>'                 end , edesc[[enter selects quickfix]])

for _, dir in ipairs({'h', 'j', 'k', 'l'}) do
    k.set('n', "<C-A-"..dir..">", function() require('misc.winsize').changeWindowSize(dir) end, desc("Resize window in " .. dir .. "direction"))
end

-- Disabled features

if not dk949.arrows then
    for _, arr in ipairs({"up", "down", "left", "right"}) do k.set({'n', 'i', 'v'}, "<"..arr..">", "<nop>", desc("dispable "..arr.." arrow")) end
end

k.set('n', "Q", "<nop>", desc[[disable ex mode]])

-- Non namespaced leader
k.set('n', "<leader>b", ":e#<CR>", desc[[leader-b to go to preavious file]])

k.set('n', "<leader>s", ":update<CR>", desc[[leader-s to update file]])

k.set('n', "<leader>t", ":tabedit ", desc[[Open file in a new tab]])

-- Namespaced leader
k.set('n', "<leader>ms", ":mksession!<CR>", desc[[Save the current session]])

k.set('n', "<Leader>mc", ":set cursorline!<CR>", desc[[cursor highlighting]])

-- Plugins

-- TODO: make this call the actual function, TODO: install nerd commenter
k.set('n', "<leader>/", "<leader>c<space>", desc[[Comment out a line]])

-- TODO: check if there is a function I can call instead, TODO: install NERTtree
k.set('n', "<leader>nn", ":NERDTreeToggle<CR>", desc[[toggle NERDtree file browser]])

-- TODO: check if there is a function I can call instead, TODO: install minimap
k.set('n', "<leader>nm", ":MinimapToggle<CR>", desc[[toggle minimap]])
