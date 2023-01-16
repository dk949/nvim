return require("utils").lspSetupCreate("haskell",
    function(capabilities, on_attach)
        local lspconfig = require("lspconfig")
        local newCap = { "codeLens" }
        if capabilities then
            capabilities = vim.tbl_extend("error", capabilities, newCap)
        else
            capabilities = newCap
        end
        lspconfig.hls.setup {
            filetypes = { 'haskell', 'lhaskell', 'cabal' },
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                single_file_support = true,
                hlintOn = true,
                completionSnippetsOn = true,
                checkParents = "CheckOnSaveAndClose",
                formattingProvider = "sakjfhkds",
                diagnosticsOnChange = true,
                liquidOn = true, --TODO
                plugin = {
                    -- ghcide plugins
                    ["ghcide-code-actions-bindings"] = { globalOn = true },
                    ["ghcide-code-actions-fill-holes"] = { globalOn = true }, --TODO
                    ["ghcide-code-actions-imports-exports"] = { globalOn = true },
                    ["ghcide-code-actions-type-signatures"] = { globalOn = true },
                    ["ghcide-completions"] = { globalOn = true, config = { autoExtendOn = true, snippetsOn = true } },
                    ["ghcide-hover-and-symbols"] = { hoverOn = true, symbolsOn = true },
                    ["ghcide-type-lenses"] = { globalOn = true, config = { mode = "always" } },

                    importLens = { codeActionsOn = true, codeLensOn = true },
                    splice = { globalOn = true },
                    retrie = { globalOn = true },
                    hlint = { codeActionsOn = true, diagnosticsOn = true },
                    haddockComments = { globalOn = true },
                    eval = { globalOn = true }, --TODO
                    class = { globalOn = true }, --TODO
                    tactics = {
                        hoverOn = true,
                        codeActionsOn = true,
                        config = {
                            max_use_ctor_actions = 5,
                            auto_gas = 4,
                            timeout_duration = 2,
                            hole_severity = nil
                        },
                        codeLensOn = true
                    },
                    pragmas = { codeActionsOn = true, completionOn = true },
                    refineImports = {
                        codeActionsOn = true,
                        codeLensOn = true
                    },
                    moduleName = {
                        globalOn = true
                    },
                },
                checkProject = true, --TODO
                maxCompletions = 40
            }
        }
    end
)
