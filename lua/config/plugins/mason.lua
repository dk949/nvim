local ENSURE_INSTALLED = { "ast-grep" }
return function()
    require("mason").setup {
        ui = {
            border = "rounded",
        },
    }
    local pkg = require("utils.pkg")
    vim.iter(ENSURE_INSTALLED):each(pkg.ensureInstalled)
end
