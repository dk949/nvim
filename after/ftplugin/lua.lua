local function snippets()
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    ls.add_snippets("lua", {
        s({ trig = "M", desc = "Module preamble" }, {
            t({
                "local M = {}",
                "",
                "",
                "",
            }),
            i(1, ""),
            t({
                "",
                "",
                "",
                "return M",
            })
        }) })
end
require "utils".ftplugin(
    require "config.common".prog:with({ ["@treesitter"] = true }),
    function()
        require "utils.lsp".enableLspTools({
            config = "lua_ls",
            mason = "lua-language-server",
        }, {
            snippets = snippets,
            override = {
                settings = {
                    Lua = {
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                        telemetry = { enable = false },
                    },
                }
            }
        })
    end
)
