return function()
    vim.opt_local.colorcolumn = "+1"
    vim.cmd[[highlight ColorColumn ctermbg=6]]
    vim.cmd[[setlocal wrap]]
end
