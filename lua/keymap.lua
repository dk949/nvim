-- TODO: updated descriptions
local k = vim.keymap
local function desc(msg) return { desc = msg, silent = true } end

local function edesc(msg) return { desc = msg, silent = true, expr = true } end

local utils = require("utils")

-- General fixes
k.set('n', "G", "Gzz", desc "jump to line centers the screen on that line")

k.set('v', "<C-C>", [["*y :let @+=@*<CR>]], desc [[ctrl-c to copy]])

k.set('n', "vv", "V", desc [[vv to select whole line]])

k.set('n', "V", "v$", desc [[V to select until the end of the line]])

k.set('n', "Y", "y$", desc [[Y to yank until the end of the line]])

k.set('t', "<C-[><C-[>", [[<C-\><C-n>]], desc [[Double escape to get to normal mode in terminal mode]])

k.set('n', "<C-l>", ":mode<CR>", desc [[redraw the screen on ctrl-l]])

k.set('n', "ZZ", function() require("termutils").smartClose() end,
    desc [[If last buffer was a terminal, erturn to that terminal]])

k.set({ 'n', 'i' }, "<A-l>", "gt", desc [[alt-l for next tab]])
k.set({ 'n', 'i' }, "<A-h>", "gT", desc [[alt-h for prev tab]])

for _, dir in ipairs { 'h', 'j', 'k', 'l' } do
    k.set({ 'i', 't' }, "<C-" .. dir .. ">", [[<C-\><C-N><C-w>]] .. dir,
        desc("use ctrl-" .. dir .. " to move between windows in insert and terminal modes"))
    k.set('n', "<C-" .. dir .. ">", "<C-w>" .. dir, desc("use ctrl-" .. dir .. " to move between windows in normal mode"))
end

k.set('n', "j", function() return (vim.bo.buftype == "quickfix") and ":cnext<CR>:wincmd p<CR>" or 'j' end,
    edesc [[j moves to next quickfix]])
k.set('n', "k", function() return (vim.bo.buftype == "quickfix") and ":cprevious<CR>:wincmd p<CR>" or 'k' end,
    edesc [[k moves to prev quickfix]])
k.set('n', "<CR>", function() return (vim.bo.buftype == "quickfix") and ":cc<CR>" or '<CR>' end,
    edesc [[enter selects quickfix]])

for _, dir in ipairs({ 'h', 'j', 'k', 'l' }) do
    k.set('n', "<C-A-" .. dir .. ">", function() utils.winsize.changeWindowSize(dir) end,
        desc("Resize window in " .. dir .. "direction"))
end

-- Disabled features

if not dk949.arrows then
    for _, arr in ipairs({ "up", "down", "left", "right" }) do k.set({ 'n', 'i', 'v' }, "<" .. arr .. ">", "<nop>",
            desc("dispable " .. arr .. " arrow"))
    end
end

k.set('n', "Q", "<nop>", desc [[disable ex mode]])

-- Non namespaced leader
k.set('n', "<leader>b", ":e#<CR>", desc [[leader-b to go to preavious file]])

k.set('n', "<leader>s", ":update<CR>", desc [[leader-s to update file]])

k.set('n', "<leader>t", ":tabedit ", desc [[Open file in a new tab]])

-- Namespaced leader
k.set('n', "<leader>ms", ":mksession!<CR>", desc [[Save the current session]])

k.set('n', "<Leader>mc", ":set cursorline!<CR>", desc [[cursor highlighting]])

k.set('n', "<Leader>mt", function() require("termutils").startTerminal() end, desc [[cursor highlighting]])

k.set('n', "<leader>mi", function() vim.lsp.buf.hover() end, desc [[Display hover infomration]])

k.set('n', "<leader>mf", function() if dk949.fmtFn then dk949.fmtFn() end end, desc [[Format current file]])

k.set('n', "<leader>crn", function() vim.lsp.buf.rename() end, desc [[Display hover infomration]])
k.set('n', "<A-cr>", function() vim.lsp.buf.code_action() end, desc [[Display hover infomration]])
k.set('n', "<leader>ccl", function()
    local c = vim.lsp.codelens;
    if c == nil then return print("codelens is nil") end
    local lenses = c.get()
    if vim.tbl_isempty(lenses) then return print("No codelenses found") end
    c.display();
    c.refresh();
    c.run();
    c.refresh()
end,
    desc [[]])
k.set('n', "<leader>cgr", function() vim.cmd [[Trouble lsp_references]] end, desc [[]])
k.set('n', "<leader>cgd", function() vim.cmd [[Trouble lsp_definitions]] end, desc [[]])

-- Plugins

k.set('n', "<leader>mg", ":Goyo<CR>", desc [[toggle Tree file browser]])

k.set('n', "<leader>nn", ":NvimTreeFindFileToggle<CR>", desc [[toggle Tree file browser]])

k.set('n', "<leader>nm", ":MinimapToggle<CR>", desc [[toggle minimap]])

k.set('n', '<Leader>ntn', function() require('todotxt-nvim').capture() end, desc [[add new todo]])

k.set('n', '<Leader>gb', ":Gitsigns blame_line<CR>", desc [[Show git blame for current line]])
k.set('n', '<Leader>gv', ":Gitsigns preview_hunk_inline<CR>", desc [[Preview hunk under cursor]])
k.set('n', ']]', ":Gitsigns next_hunk<CR>", desc [[go to next hunk]])
k.set('n', '[[', ":Gitsigns prev_hunk<CR>", desc [[go to next hunk]])

local i = "insert"
local n = "normal"

-- telescope
k.set('n', "<leader>f", function() TeleConfig("builtin", n) end, desc [[]])
k.set('n', "<leader>ftl", function() TeleConfig("reloader", n) end, desc [[]])
k.set('n', "<leader>ftp", function() TeleConfig("pickers", i) end, desc [[]])
k.set('n', "<leader>ftr", function() TeleConfig("resume", n) end, desc [[]])
k.set('n', "<leader>ftup", function() TeleConfig("planets", n) end, desc [[]])

-- Tags
k.set('n', "<leader>ftac", function() TeleConfig("current_buffer_tags", n) end, desc [[]])
k.set('n', "<leader>ftas", function() TeleConfig("tagstack", n) end, desc [[]])
k.set('n', "<leader>ftat", function() TeleConfig("tags", n) end, desc [[]])

-- file
k.set('n', "<leader>ff/", function() TeleConfig("current_buffer_fuzzy_find", i) end, desc [[]])
k.set('n', "<leader>ffb", function() TeleConfig("buffers", n) end, desc [[]])
k.set('n', "<leader>fff", function() TeleConfig("find_files", i) end, desc [[]])
k.set('n', "<leader>ffo", function() TeleConfig("oldfiles", n) end, desc [[]])
k.set('n', "<leader>ffr", function() TeleConfig("live_grep", i) end, desc [[]])

-- misc
k.set('n', "<leader>fmj", function() TeleConfig("jumplist", n) end, desc [[]])
k.set('n', "<leader>fml", function() TeleConfig("loclist", n) end, desc [[]])
k.set('n', "<leader>fmm", function() TeleConfig("marks", n) end, desc [[]])
k.set('n', "<leader>fmq", function() TeleConfig("quickfix", n) end, desc [[]])
k.set('n', "<leader>fman", function() TeleConfig("man_pages") end, desc [[]])

-- vim
k.set('n', "<leader>fva", function() TeleConfig("autocommands", n) end, desc [[]])
k.set('n', "<leader>fvch", function() TeleConfig("command_history", n) end, desc [[]])
k.set('n', "<leader>fvcl", function() TeleConfig("colorscheme", n) end, desc [[]])
k.set('n', "<leader>fvcm", function() TeleConfig("commands", n) end, desc [[]])
k.set('n', "<leader>fvf", function() TeleConfig("filetypes", i) end, desc [[]])
k.set('n', "<leader>fvhi", function() TeleConfig("highlights", n) end, desc [[]])
k.set('n', "<leader>fvhl", function() TeleConfig("help_tags", i) end, desc [[]])
k.set('n', "<leader>fvk", function() TeleConfig("keymaps", n) end, desc [[]])
k.set('n', "<leader>fvo", function() TeleConfig("vim_options", n) end, desc [[]])
k.set('n', "<leader>fvr", function() TeleConfig("registers", n) end, desc [[]])
k.set('n', "<leader>fvsh", function() TeleConfig("search_history", n) end, desc [[]])
k.set('n', "<leader>fvss", function() TeleConfig("spell_suggest", n) end, desc [[]])


-- Git
k.set('n', "<leader>fgb", function() TeleConfig("git_branches", n) end, desc [[]])
k.set('n', "<leader>fgc", function() TeleConfig("git_commits", n) end, desc [[]])
k.set('n', "<leader>fgf", function() TeleConfig("git_files", n) end, desc [[]])
k.set('n', "<leader>fglb", function() TeleConfig("git_bcommits", n) end, desc [[]])
k.set('n', "<leader>fgs", function() TeleConfig("git_stash", n) end, desc [[]])
k.set('n', "<leader>fgv", function() TeleConfig("git_status", n) end, desc [[]])

-- lsp
k.set('n', "<leader>ful3", function() TeleConfig("lsp_document_symbols", n) end, desc [[]])
k.set('n', "<leader>ful4", function() TeleConfig("lsp_dynamic_workspace_symbols", i) end, desc [[]])
k.set('n', "<leader>cd", function() TeleConfig("diagnostics", n) end, desc [[]])

-- nothing?
k.set('n', "<leader>ful5", function() TeleConfig("lsp_implementations") end, desc [[]])
k.set('n', "<leader>ful8", function() TeleConfig("lsp_type_definitions") end, desc [[]])
