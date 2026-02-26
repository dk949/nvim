local M = {}

M.pythonPrg = "black --no-color -q -"
M.cmakePrg = "cmake-format - -o -"
M.fortranProg = "fprettify --silent"
M.zigPrg = "zig fmt --stdin"
M.lspExpr = "v:lua.vim.lsp.buf.format()"
M.goPrg = "goimports"
M.jsonPrg = "jq --indent 2"

return M
