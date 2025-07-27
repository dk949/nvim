local ENSURE_INSTALLED = { "ast-grep" }
return function()
    require("mason").setup {}
    local pkg = require("utils.pkg")
    vim.iter(ENSURE_INSTALLED):each(pkg.ensureInstalled)
end
