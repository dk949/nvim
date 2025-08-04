local function snippets()
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local d = ls.dynamic_node
    local sn = ls.snippet_node
    ls.add_snippets("go", {
        s({ trig = "iferr", desc = "if err != nil" }, {
            t "if ", i(1, "err"), t { " != nil {", "" },
            d(2, function(args)
                    return sn(nil, { t "\t", i(1, "return " .. args[1][1]) })
                end,
                { 1 }
            ),
            t { "", "}" },
        }),

    })
end
require "utils".ftplugin(
    require "config.common".prog,
    function()
        require "utils.lsp".enableLsp("gopls", { snippets = snippets })
    end
)
