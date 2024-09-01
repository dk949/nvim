return require("utils").makeDefaultLspCounfig("jsonls", {
    -- https://github.com/ahmedelgabri/dotfiles/blob/c2e2e3718e769020f1468048e33e60ad8a97edfc/config/.vim/lua/_/lsp.lua#L329-L378
    filetypes = { "json", "jsonc", },
    settings = {
        json = {
            -- Schemas https://www.schemastore.org
            schemas = {
                { fileMatch = { "CMakePresets.json" },                              url = "https://raw.githubusercontent.com/Kitware/CMake/master/Help/manual/presets/schema.json" },
                { fileMatch = { "package.json" },                                   url = "https://json.schemastore.org/package.json" },
                { fileMatch = { "tsconfig*.json" },                                 url = "https://json.schemastore.org/tsconfig.json" },
                { fileMatch = { ".eslintrc", ".eslintrc.json" },                    url = "https://json.schemastore.org/eslintrc.json" },
                { fileMatch = { ".babelrc", ".babelrc.json", "babel.config.json" }, url = "https://json.schemastore.org/babelrc.json" },
                { fileMatch = { "lerna.json" },                                     url = "https://json.schemastore.org/lerna.json" },
                { fileMatch = { "now.json", "vercel.json" },                        url = "https://json.schemastore.org/now.json" },
                { fileMatch = { ".vimspector.json" },                               url = "https://puremourning.github.io/vimspector/schema/vimspector.schema.json" },
                {
                    fileMatch = {
                        ".prettierrc",
                        ".prettierrc.json",
                        "prettier.config.json"
                    },
                    url = "https://json.schemastore.org/prettierrc.json"
                },
                {
                    fileMatch = {
                        ".stylelintrc",
                        ".stylelintrc.json",
                        "stylelint.config.json"
                    },
                    url = "http://json.schemastore.org/stylelintrc.json"
                }
            }
        }
    }
})
