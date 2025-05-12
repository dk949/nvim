local M = {}
local lsp = vim.lsp



function M.toggleInlay()
    lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled())
end


return M
