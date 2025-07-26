---comment
---@param cmd string
local function runHelp(cmd)
    local word = vim.fn.expand("<cword>")
    cmd = cmd .. ' ' .. word
    print("Running help: ", cmd)
    vim.cmd(cmd)
end


local CMDs = {
    c = "Man 3",
    cpp = "Man 3",
    lua = "h",
}

return {
    althelp = function()
        local cmd = vim.b.help_cmd
        if cmd then return runHelp(cmd) end
        cmd = CMDs[vim.o.filetype]
        if cmd then return runHelp(cmd) end
    end
}
