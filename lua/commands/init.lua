local cut = require("commands.utils")
local command = vim.api.nvim_create_user_command
require("commands.git")

command("W", "w", {})
command("E", "e <args>", { complete = "file", nargs = 1 })
cut.addAbrev("tb", "Tabularize /")
cut.addAbrev("bw", [[call v:lua.require("utils.log").error("Use bd instead!")]])
