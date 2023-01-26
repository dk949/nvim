local tsserver = require("utils").lspSetupCreate("ts",
    function(capabilities, on_attach)
        require("lspconfig").tsserver.setup {
            capabilities = capabilities,
            on_attach = on_attach,
            completion = { callSnippet = "Replace" },
        }
    end
)

local eslint = require("utils").lspSetupCreate("js",
    function(capabilities, on_attach)
        require("lspconfig").eslint.setup {
            capabilities = capabilities,
            on_attach = on_attach,
            completion = { callSnippet = "Replace" },
            settings = { packageManager = "yarn" },
        }
    end
)

return {
    server = function(capabilities, on_attach)
        tsserver(capabilities, on_attach)
        eslint(capabilities, on_attach)
    end,
    masonInstall = { "tsserver", "eslint" }
}
