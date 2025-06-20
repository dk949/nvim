return {
    opts = {},
    cond = function()
        local conf = vim.fs.normalize(vim.fs.joinpath(vim.env.XDG_CONFIG_HOME or "~/.config", "nvim"))
        local cwd = vim.fs.normalize(vim.env.PWD)
        return vim.startswith(cwd, conf)
    end
}
