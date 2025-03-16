-- TODO: updated descriptions
local k = vim.keymap
local function desc(msg) return { desc = msg, silent = true } end

local function edesc(msg) return { desc = msg, silent = true, expr = true } end
local function redesc(msg) return { desc = msg, silent = true, expr = true, replace_keycodes = false } end
local function ldesc(msg) return { desc = msg, silent = true, buffer = true } end

local utils = require("utils")


local function teleTheme(mode)
    if vim.g.neovide then
        return { dir_icon = '❯', initial_mode = mode, sections = { "1", "2", "3" } }
    else
        return require('telescope.themes').get_ivy({ dir_icon = '❯', initial_mode = mode, sections = { "1", "2", "3" } })
    end
end

local function teleConfig(str, mode)
    return require('telescope.builtin')[str](teleTheme(mode))
end



-- General fixes
k.set('n', "G", "Gzz", desc "jump to line centers the screen on that line")

k.set('v', "<C-C>", [["*y :let @+=@*<CR>]], desc [[ctrl-c to copy]])

k.set('n', "vv", "V", desc [[vv to select whole line]])

k.set('n', "V", "v$", desc [[V to select until the end of the line]])

k.set('n', "Y", "y$", desc [[Y to yank until the end of the line]])


k.set('n', "<A-y>", "zl", desc [[use alt-y to scroll right]])
k.set('n', "<A-e>", "zh", desc [[use alt-e to scroll left]])

vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    callback = function()
        k.set('n', "gf",
            ":silent call File_line_goto_file_line(expand('<cWORD>')) | doautocmd InsertLeave<CR>",
            desc [[use file:line:col instead of <cfile>]])
    end
})

k.set('t', "<C-[><C-[>", [[<C-\><C-n>:doautocmd User TermUtilsLeave<CR>]],
    desc [[Double escape to get to normal mode in terminal mode]])

-- k.set('n', "ZZ", function()
--     if vim.bo.ft == "oil" then
--         vim.cmd[[norm! ZZ]]
--     else
--         require("termutils").smartClose()
--     end
-- end, desc [[If last buffer was a terminal, return to that terminal]])

k.set({ 'n', 'i' }, "<A-l>", "gt", desc [[alt-l for next tab]])
k.set({ 'n', 'i' }, "<A-h>", "gT", desc [[alt-h for prev tab]])

for _, dir in ipairs { 'h', 'j', 'k', 'l' } do
    k.set({ 'i', 't' }, "<C-" .. dir .. ">", [[<C-\><C-N><C-w>]] .. dir,
        desc("use ctrl-" .. dir .. " to move between windows in insert and terminal modes"))
    k.set('n', "<C-" .. dir .. ">", "<C-w>" .. dir, desc("use ctrl-" .. dir .. " to move between windows in normal mode"))
end

k.set('t', "<C-l>", [[<space>clear<CR>]], desc [[clear terminal screen]])

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


k.set('n', "<A-j>", "<CMD>m +1<CR>", desc [[move line down]])
k.set('n', "<A-k>", "<CMD>m -2<CR>", desc [[move line up]])

k.set('v', "<A-j>", ":m '>+1<CR>gv", desc [[move lines down]])
k.set('v', "<A-k>", ":m '<-2<CR>gv", desc [[move lines up]])

-- Disabled features

if not dk949.arrows then
    for _, arr in ipairs({ "up", "down", "left", "right" }) do
        k.set({ 'n', 'i', 'v' }, "<" .. arr .. ">", "<nop>",
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

k.set('n', "<Leader>mt", function() require("termutils").startTerminal() end, desc [[start the terminal]])

k.set('n', "<leader>mi", function() vim.lsp.buf.hover() end, desc [[Display hover infomration]])

k.set('n', "<leader>mf",
    function()
        if dk949.fmtFn and dk949.fmtFn[vim.fn.bufnr()] then
            dk949.fmtFn[vim.fn.bufnr()]()
        end
    end,
    desc [[Format current file]])

k.set('n', "<leader>crn", function() vim.lsp.buf.rename() end, desc [[Rename symbol]])
k.set('n', "<A-cr>", function() vim.lsp.buf.code_action() end, desc [[Code action]])
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
    desc [[Code lense]])
k.set('n', "<leader>cj", function() vim.diagnostic.goto_next() end, desc [[Go to next diagnistic]])
k.set('n', "<leader>ck", function() vim.diagnostic.goto_prev() end, desc [[Go to next previous]])
k.set('n', "<leader>ci", function() vim.diagnostic.open_float() end, desc [[Open diagnistic in a float]])
k.set('n', "<leader>ca", ":ALEToggle<CR>", desc [[Toggle ALE]])
k.set('n', "<leader>cgr", function() vim.cmd [[Trouble lsp_references]] end, desc [[Go to reference]])
k.set('n', "<leader>cgd", function() vim.cmd [[Trouble lsp_definitions]] end, desc [[Go to definition]])
k.set('n', "<leader>ch", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
    desc [[Toggle inlay hints]])

-- Plugins

k.set('n', "<leader>:", "<cmd>IconPickerNormal<cr>", desc [[Pick an icon in normal mode]])
k.set('i', "<C-x>;", "<cmd>IconPickerInsert<cr>", desc [[Pick an icon in insert mode]])

k.set('n', "<leader>mg", ":Goyo<CR>", desc [[toggle Goyo]])

k.set('n', "<leader>nn", "<CMD>Oil --float<CR>", desc [[toggle file browser]])

k.set('n', "<leader>nm", ":MinimapToggle<CR>", desc [[toggle minimap]])

k.set('n', '<Leader>gb', ":Gitsigns blame_line<CR>", desc [[Show git blame for current line]])
k.set('n', '<Leader>gv', ":Gitsigns preview_hunk_inline<CR>", desc [[Preview hunk under cursor]])
k.set('n', '<Leader>gu', ":Gitsigns undo_stage_hunk<CR>", desc [[Undo last hunk stage]])
k.set('n', '<Leader>gd', ":Gitsigns toggle_deleted<CR>", desc [[Toggle deleted lines]])
k.set('n', '<leader>j', ":Gitsigns next_hunk<CR>", desc [[go to next hunk]])
k.set('n', '<leader>k', ":Gitsigns prev_hunk<CR>", desc [[go to previous hunk]])

vim.keymap.set('i', '<C-Space>', 'copilot#Accept("")', redesc [[Accept copilot suggestion]])
vim.keymap.set('i', '<C-M-Space>', '<Plug>(copilot-dismiss)', desc [[Dismiss copilot suggestion]])

local i = "insert"
local n = "normal"

-- telescope
k.set('n', "<leader>f", function() teleConfig("builtin", n) end, desc [[]])
k.set('n', "<leader>ftl", function() teleConfig("reloader", n) end, desc [[]])
k.set('n', "<leader>ftp", function() teleConfig("pickers", i) end, desc [[]])
k.set('n', "<leader>ftr", function() teleConfig("resume", n) end, desc [[]])
k.set('n', "<leader>ftup", function() teleConfig("planets", n) end, desc [[]])

-- Tags
k.set('n', "<leader>ftac", function() teleConfig("current_buffer_tags", n) end, desc [[]])
k.set('n', "<leader>ftas", function() teleConfig("tagstack", n) end, desc [[]])
k.set('n', "<leader>ftat", function() teleConfig("tags", n) end, desc [[]])

-- file
k.set('n', "<leader>ff/", function() teleConfig("current_buffer_fuzzy_find", i) end, desc [[]])
k.set('n', "<leader>ffb", function() teleConfig("buffers", n) end, desc [[]])
k.set('n', "<leader>fff", function() teleConfig("find_files", i) end, desc [[]])
k.set('n', "<leader>ffo", function() teleConfig("oldfiles", n) end, desc [[]])
k.set('n', "<leader>ffr", function() teleConfig("live_grep", i) end, desc [[]])

-- misc
k.set('n', "<leader>fmj", function() teleConfig("jumplist", n) end, desc [[]])
k.set('n', "<leader>fml", function() teleConfig("loclist", n) end, desc [[]])
k.set('n', "<leader>fmm", function() teleConfig("marks", n) end, desc [[]])
k.set('n', "<leader>fmq", function() teleConfig("quickfix", n) end, desc [[]])
k.set('n', "<leader>fman", function() teleConfig("man_pages", i) end, desc [[]])

-- vim
k.set('n', "<leader>fva", function() teleConfig("autocommands", n) end, desc [[]])
k.set('n', "<leader>fvch", function() teleConfig("command_history", n) end, desc [[]])
k.set('n', "<leader>fvcl", function() teleConfig("colorscheme", n) end, desc [[]])
k.set('n', "<leader>fvcm", function() teleConfig("commands", n) end, desc [[]])
k.set('n', "<leader>fvf", function() teleConfig("filetypes", i) end, desc [[]])
k.set('n', "<leader>fvhi", function() teleConfig("highlights", n) end, desc [[]])
k.set('n', "<leader>fvhl", function() teleConfig("help_tags", i) end, desc [[]])
k.set('n', "<leader>fvk", function() teleConfig("keymaps", i) end, desc [[]])
k.set('n', "<leader>fvo", function() teleConfig("vim_options", n) end, desc [[]])
k.set('n', "<leader>fvr", function() teleConfig("registers", n) end, desc [[]])
k.set('n', "<leader>fvsh", function() teleConfig("search_history", n) end, desc [[]])
k.set('n', "z=", function() teleConfig("spell_suggest", i) end, desc [[]])


-- Git
k.set('n', "<leader>fgb", function() teleConfig("git_branches", n) end, desc [[]])
k.set('n', "<leader>fgc", function() teleConfig("git_commits", n) end, desc [[]])
k.set('n', "<leader>fgf", function() teleConfig("git_files", n) end, desc [[]])
k.set('n', "<leader>fglb", function() teleConfig("git_bcommits", n) end, desc [[]])
k.set('n', "<leader>fgs", function() teleConfig("git_stash", n) end, desc [[]])
k.set('n', "<leader>fgv", function() teleConfig("git_status", n) end, desc [[]])

-- lsp
k.set('n', "<leader>ful3", function() teleConfig("lsp_document_symbols", n) end, desc [[]])
k.set('n', "<leader>ful4", function() teleConfig("lsp_dynamic_workspace_symbols", i) end, desc [[]])
k.set('n', "<leader>cd", function() teleConfig("diagnostics", n) end, desc [[]])

-- nothing?
k.set('n', "<leader>ful5", function() teleConfig("lsp_implementations") end, desc [[]])
k.set('n', "<leader>ful8", function() teleConfig("lsp_type_definitions") end, desc [[]])

-- vimspector
k.set('n', "<leader>f6", "<Plug>VimspectorDisassemble", desc [[Disassemble debugged program]])
k.set('n', "<leader>md", "<Plug>VimspectorBalloonEval", desc [[Evaluate statement]])
k.set('v', "<leader>md", "<Plug>VimspectorBalloonEval", desc [[Evaluate statement]])
k.set('n', "<leader>db", "<Plug>VimspectorBreakpoints", desc [[Open break point window]])
