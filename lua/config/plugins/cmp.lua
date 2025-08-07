local lsp_ut = require("utils.lsp")
return function()
    local cmp = require("cmp")
    local ls = require("luasnip")
    cmp.setup {
        snippet = { expand = function(args) ls.lsp_expand(args.body) end, },
        -- TODO(dk949): Put this with the other key maps
        mapping = {
            ["<C-n>"] = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                else
                    cmp.complete()
                end
            end,
            ["<C-p>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                else
                    fallback()
                end
            end, { 'i' }),
            ["<CR>"] = cmp.mapping(cmp.mapping.confirm({ select = true }), { "i" }),
            ["<C-i>"] = cmp.mapping(function(fallback)
                if ls.locally_jumpable(1) then
                    ls.jump(1)
                else
                    fallback()
                end
            end, { "i" }),
            ["<C-S-i>"] = cmp.mapping(function(fallback)
                if ls.locally_jumpable(-1) then
                    ls.jump(-1)
                else
                    fallback()
                end
            end, { "i" }),

        },
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
