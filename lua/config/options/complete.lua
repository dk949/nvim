local utils = require("utils")
vim.opt.completeopt:remove("menu")
vim.opt.completeopt:append("menuone")
utils.withAugroup("completions", function(grp)
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client:supports_method('textDocument/completion') then
                vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = false })
            end
        end,
        group = grp
    })
end)
