return function ()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_gb"

    vim.opt_local.colorcolumn = "+1"
    vim.cmd[[highlight ColorColumn ctermbg=6]]

    vim.cmd[[setlocal wrap linebreak nolist]]
    vim.cmd[[setlocal textwidth=80]]

    vim.keymap.set('n', 'j', "gj", {silent = true, buffer = true})
    vim.keymap.set('n', 'k', "gk", {silent = true, buffer = true})
    vim.keymap.set('n', 'gj', "j", {silent = true, buffer = true})
    vim.keymap.set('n', 'gk', "k", {silent = true, buffer = true})
end
