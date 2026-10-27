local enableLspTools = require "utils.lsp".enableLspTools

local function drop_tw_import(bufnr, diags)
    return vim.tbl_filter(function(d)
        local line = vim.api.nvim_buf_get_lines(bufnr, d.range.start.line, d.range.start.line + 1, false)[1] or ''
        return not line:match('^%s*@import.-source%(')
    end, diags)
end

require "utils".ftplugin(
    require "config.common".prog:with({
        ["@treesitter"] = { "highlight" },
        formatexpr = require("config.common.formatting").lspExpr,
    }),
    function()
        enableLspTools { config = "tailwindcss", mason = "tailwindcss-language-server" }
        enableLspTools({ config = "cssls", mason = "css-lsp" }, {
            override = {
                settings = {
                    css = { lint = { unknownAtRules = 'ignore' } },
                },
                handlers = {
                    -- push model (server sends diagnostics)
                    ['textDocument/publishDiagnostics'] = function(err, result, ctx)
                        if result then
                            result.diagnostics = drop_tw_import(vim.uri_to_bufnr(result.uri), result.diagnostics)
                        end
                        return vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx)
                    end,
                    -- pull model (Neovim asks for diagnostics; used in 0.11+/0.12)
                    ['textDocument/diagnostic'] = function(err, result, ctx)
                        if result and result.items then
                            result.items = drop_tw_import(vim.uri_to_bufnr(ctx.params.textDocument.uri), result.items)
                        end
                        return vim.lsp.diagnostic.on_diagnostic(err, result, ctx)
                    end,
                },
            }
        })
    end
)
