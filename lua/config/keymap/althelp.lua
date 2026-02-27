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

local FNs = {
    cmake = function()
        local word = vim.fn.expand("<cword>")
        vim.cmd "Man cmake-commands"
        local last_search = vim.fn.getreg("/")
        vim.cmd("/^   \\<" .. word)
        vim.fn.setreg("/", last_search)
    end
}

return {
    althelp = function()
        local cmd = vim.b.help_cmd
        if cmd then return runHelp(cmd) end
        cmd = CMDs[vim.o.filetype]
        if cmd then return runHelp(cmd) end
        local fn = FNs[vim.o.filetype]
        if fn then return fn() end
    end
}
