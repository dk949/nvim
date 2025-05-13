if vim.b.ftp_is_done then return end

vim.lsp.enable("lua_ls")
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        local reg = require("mason-registry")
        if reg.is_installed("lua-language-server") then return end
        local pkg = reg.get_package("lua-language-server")
        pkg:install()
    end
})
vim.b.ftp_is_done = true
