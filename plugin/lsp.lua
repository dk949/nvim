local function on_attach(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

function LSPConfigFn()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local lspconfig = require'lspconfig'

    lspconfig.ccls.setup {
        cmd =  {"ccls","--log-file=/tmp/ccls.log","-v=1"},
        filetypes = {"c","cc","cpp","c++","objc","objcpp"},
        init_options = {
            cache = {directory = "/tmp/ccls"},
            client = {snippetSupport = true},
            index = {onChange = true},
            highlight = {lsRanges = true}
        },
        on_attach = on_attach,
        capabilities = capabilities,
    }

    lspconfig.zls.setup{
        cmd = {"zls"},
        filetypes = {"zig"}
    }

    local luasnip = require 'luasnip'

    local cmp = require 'cmp'
    cmp.setup {
        view = {entries = "native"},
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm {behavior = cmp.ConfirmBehavior.Replace,select = true},
            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { 'i', 's' }),
        }),
        sources = {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
        },
    }



    -- Formatting setup
    localPlugins.format.addFmtAutocmd{
        name    = "CPPGroup",
        pattern = {"c", "cpp"},
        fnOrCMD = [[:silent execute "!clang-format --style=file -i %"]],
        buf     = vim.fn.bufnr(),
    }
end
