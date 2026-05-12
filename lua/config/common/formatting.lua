local M = {}

M.pythonPrg = "black --no-color -q -"
M.cmakePrg = "cmake-format - -o -"
M.fortranProg = "fprettify --silent"
M.zigPrg = "zig fmt --stdin"
M.rustPrg = "rustfmt --emit stdout"
M.lspExpr = "v:lua.vim.lsp.buf.format()"
M.goPrg = "goimports"
M.jsonPrg = "jq --indent 2"
M.shExpr =[[execute("norm! " .. v:lnum .. "G=" .. v:count .. "j")]]


return M
