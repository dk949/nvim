local function snippets()
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    ls.add_snippets("python", {
        s({ trig = "struct", desc = "create a dataclass" }, {
            t({ [[@dataclass]],
                [[class ]] }),
            i(1, "ClassName"),
            t({ ":", "    " }),
            i(2, "pass"),
        }),
        s({ trig = "structf", desc = "create a frozen dataclass" }, {
            t({ [[@dataclass(frozen=True)]],
                [[class ]] }),
            i(1, "ClassName"),
            t({ ":", "    " }),
            i(2, "pass"),
        })

    })
end

require "utils".ftplugin(
    require "config.common".prog:with {
        -- formatexpr = [[v:lua.require("config.common.formatting").pythonExpr()]],
        formatprg = require("config.common.formatting").pythonPrg,
    },
    function()
        require "utils.lsp".enableLspTools("basedpyright", { snippets = snippets })
    end
)
