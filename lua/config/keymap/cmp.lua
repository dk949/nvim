local M = {}

function M.complete_next()
    local cmp = require("cmp")
    return function()
        if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        else
            cmp.complete()
        end
    end
end

function M.complete_prev()
    local cmp = require("cmp")
    return function(fallback)
        if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
        else
            fallback()
        end
    end
end

function M.confirm()
    local cmp = require("cmp")
    return cmp.mapping.confirm({ select = true })
end

function M.jump_fwd()
    local ls = require("luasnip")
    return function(fallback)
        if ls.locally_jumpable(1) then
            ls.jump(1)
        else
            fallback()
        end
    end
end

function M.jump_back()
    local ls = require("luasnip")
    return function(fallback)
        if ls.locally_jumpable(-1) then
            ls.jump(-1)
        else
            fallback()
        end
    end
end

return M
