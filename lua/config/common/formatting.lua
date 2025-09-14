local log = require("utils.log")
local M = {}

M.pythonPrg = "black --no-color -q -"
M.cmakePrg = "cmake-format - -o -"
M.fortranProg = "fprettify --silent"
M.zigPrg = "zig fmt --stdin"

return M
