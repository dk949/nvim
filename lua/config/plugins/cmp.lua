return function()
    local keymap = require "config.keymap".cmp
    local cmp = require("cmp")
    local ls = require("luasnip")
    cmp.setup {
        window = {
            completion = cmp.config.window.bordered({ border = "none", winhighlight = "" }),
            documentation = cmp.config.window.bordered({ border = "none", winhighlight = "" }),
        },
        snippet = { expand = function(args) ls.lsp_expand(args.body) end, },
        mapping = keymap:transform(function(_, m)
            local mode
            if type(m.mode) == "string" then
                mode = { m.mode }
            else
                mode = m.mode
            end
            return m.lhs, cmp.mapping(m.rhs(), mode)
        end)
        ,
        sources = cmp.config.sources(
            {
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
            }, {
                { name = 'buffer' },
            }
        )
    }
end
