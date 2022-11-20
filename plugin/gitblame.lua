dk949.gitblamemode = false
vim.g.GBlameVirtualTextEnable = 0

function toggleGitBlameMode()
    if not dk949.gitblamemode then
        vim.keymap.set('n', 'j', "j:call gitblame#echo()<CR>", {silent = true, buffer = true})
        vim.keymap.set('n', 'k', "k:call gitblame#echo()<CR>", {silent = true, buffer = true})
        dk949.gitblamemode = true
    else
        vim.keymap.del('n', 'j', {buffer = true})
        vim.keymap.del('n', 'k', {buffer = true})
        dk949.gitblamemode = false
    end
end

