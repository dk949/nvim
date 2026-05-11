local ENSURE_INSTALLED = { "ast-grep" }
return function()
    require("mason").setup {
        ui = {
            border = "rounded",
        },
    }
    local pkg = require("utils.pkg")
    pkg.ensureInstalled(ENSURE_INSTALLED)
end
