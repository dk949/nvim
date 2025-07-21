return {
    opts = {},
    cond = function()
        -- Enable lazydev with nvim --cmd 'let g:enable_lazydev=1'
        if vim.g.enable_lazydev then return true end
        local conf = vim.fs.normalize(vim.fs.joinpath(vim.env.XDG_CONFIG_HOME or "~/.config", "nvim"))
        local cwd = vim.fs.normalize(vim.env.PWD)
        return vim.startswith(cwd, conf)
    end
}
