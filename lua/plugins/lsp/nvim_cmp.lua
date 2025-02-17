-- https://github.com/hrsh7th/nvim-cmp


-- Autocompletion plugin
return {
    "hrsh7th/nvim-cmp",
    as = "cmp",
    after = {
        "snip",
        "cmp-lsp",
        "cmp-snip",
        "cmp-buffer",
    },
    config = function()
        local cmp = require 'cmp'
        local luasnip = require 'luasnip'
        local has_words_before = function()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end
        local mappings = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true },
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                    -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                    -- they way you will only jump inside the snippet region
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, { "i", "s" }),

            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s" }),
        })
        mappings["<C-Space>"] = nil
        local conf = {
            view = { entries = "native" },
            snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
            mapping = mappings,
            sources = {
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'buffer' },
                { name = 'path' },
            },
        }

        for lang, _ in pairs(require("lang_features").feat.lspconfig) do
            cmp.setup.filetype(lang, conf)
        end
        cmp.setup.filetype("markdown", conf)
    end
}
