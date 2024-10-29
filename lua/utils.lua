local M = {}

function M.wincmd(cmd)
    vim.cmd("wincmd " .. cmd)
end

function M.fnOrVal(val, ...)
    if type(val) == 'function' then
        return val(...)
    else
        return val
    end
end

function M.stripString(s)
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end

function M.openWindow(opts)
    if opts == nil then opts = {} end
    local vert = true
    local splitFn = "split"
    local listed = true
    local scartch = true
    if opts.vert ~= nil then vert = opts.vert end
    if opts.splitFn ~= nil then splitFn = opts.splitFn end
    if opts.listed ~= nil then listed = opts.listed end
    if opts.scartch ~= nil then scartch = opts.scartch end
    ---@diagnostic disable-next-line: cast-local-type
    if vert then vert = "vert " else vert = "" end

    vim.cmd(vert .. splitFn)
    local win = vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_create_buf(listed, scartch)
    vim.api.nvim_win_set_buf(win, buf)
    return win, buf
end

function M.switch(on)
    return function(stmt)
        if stmt[on] ~= nil then
            return M.fnOrVal(stmt[on], on)
        else
            for k, v in pairs(stmt) do
                if type(k) == "table" and vim.tbl_islist(k) then
                    for _, option in ipairs(k) do
                        if option == on then
                            return M.fnOrVal(v, option)
                        end
                    end
                end
            end
            return M.fnOrVal(stmt.__default, on)
        end
    end
end

-- Callback generation

-- TODO
function M.setter(opts)
    return function()
        for opt, val in pairs(opts) do
            vim.o[opt] = val
        end
    end
end

function M.cmdCB(cmd)
    return function()
        return vim.cmd(cmd)
    end
end

-- LSP

local setups = {}
--- create an lsp setup function
---@param name string|number name or ID of the server (has to be usnique
---@param fn function function which sets up the server. Will be ran once
---@return function
function M.lspSetupCreate(name, fn)
    return function(capabilities, on_attach)
        if not setups[name] then
            fn(capabilities, on_attach)
            vim.cmd [[:LspStart]]
            setups[name] = true
        end
    end
end

--- make default lsp configuration
--- "good enough" for most applications
---@param servername string name of the server
---@param opts? {settings?:table,init_options?:table,filetypes?:table|string,root_dir?:table,install?:boolean} optional options for the lsp
---@return table?
function M.makeDefaultLspCounfig(servername, opts)
    if opts == nil then opts = {} end
    return {
        server = M.lspSetupCreate(servername,
            function(capabilities, on_attach)
                local lspconfig = require("lspconfig")
                local setup = {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    completion = { callSnippet = "Replace" }
                }
                if opts.settings then setup.settings = opts.settings end
                if opts.init_options then setup.init_options = opts.init_options end
                if opts.filetypes then setup.filetypes = opts.filetypes end
                if opts.root_dir then setup.root_dir = lspconfig.util.root_pattern(unpack(opts.root_dir)) end
                lspconfig[servername].setup(setup)
            end
        ),
        masonInstall = (
            function()
                if opts.install == nil or opts.install == true then
                    return servername
                else
                    return nil
                end
            end)()
    }
end

-- Printing

function M.hlPrint(hl, ...)
    local arg = { ... }
    local text = {}
    for i, v in ipairs(arg) do
        text[i] = ({ tostring(v), hl })
    end
    vim.api.nvim_echo(text, true, {})
end

function M.warnPrint(...)
    M.hlPrint("WarningMsg", ...)
end

function M.errPrint(...)
    M.hlPrint("ErrorMsg", ...)
end

function M.makeLocalRequire(mod1)
    return function(mod2) return require(mod1 .. '.' .. mod2) end
end

M.winsize = {}
M.winsize.Pos = 1
M.winsize.Neg = -1
function M.winsize.chWidth(dir, inc)
    vim.api.nvim_win_set_width(0, vim.api.nvim_win_get_width(0) + (inc * dir))
end

function M.winsize.chHeight(dir, inc)
    vim.api.nvim_win_set_height(0, vim.api.nvim_win_get_height(0) + (inc * dir))
end

function M.winsize.changeWindowSize(letter)
    local _ = M.winsize
    assert(type(letter) == "string" and #letter == 1, "expected letter to be a character")
    if vim.fn.winnr('$') <= 1 then return end

    local pos = vim.api.nvim_win_get_position(0)

    local winChange = M.switch(letter) {
        h = function() return (pos[2] == 0) and { _.chWidth, _.Neg } or { _.chWidth, _.Pos } end,
        j = function() return (pos[1] == 0) and { _.chHeight, _.Pos } or { _.chHeight, _.Neg } end,
        k = function() return (pos[1] == 0) and { _.chHeight, _.Neg } or { _.chHeight, _.Pos } end,
        l = function() return (pos[2] == 0) and { _.chWidth, _.Pos } or { _.chWidth, _.Neg } end,
    }
    winChange[1](winChange[2], dk949.winSzInc)
end

--- run a shell command
---@param cmd string|string[]
---@param opts { runner: "bang"|"system", silent: nil|boolean }|nil
---@return number,string|nil
function M.shRun(cmd, opts)
    if opts == nil then opts = {} end
    if opts.runner == nil then opts.runner = "bang" end
    local runnerFn = nil
    if opts.runner == "bang" then
        local runner = ""
        if opts.silent then runner = "silent " end
        runner = runner .. "execute \"!"
        if type(cmd) == "string" then
            runner = runner .. cmd
        elseif type(cmd) == "table" then
            runner = runner .. table.concat(cmd, " ")
        end
        runner = runner .. '"'
        runnerFn = function() vim.cmd(runner) end
    elseif opts.runner == "system" then
        runnerFn = function() return vim.fn.system(cmd) end
    else
        error("Expected runner to be one of 'bang' or 'system'")
    end

    local res = runnerFn()
    if opts.silent then
        return vim.v.shell_error
    else
        return vim.v.shell_error, res
    end
end

--- Set color fot a highlight group
---@param group string
---@param params {ctermfg:number|string, ctermbg:number|string, cterm:string, guifg:string, guibg:string, guisp:string, gui:string}
function M.hi(group, params)
    assert(type(params) == "table", "Expected a table got " .. type(params))
    local arg = ""
    for key, value in pairs(params) do
        arg = arg .. " " .. tostring(key) .. '=' .. tostring(value)
    end

    vim.cmd("hi " .. group .. arg)
end

---
---@param tbl any[]
---@return any[]
function M.unique(tbl)
    assert(vim.tbl_islist(tbl))
    local vals = {}
    for _, value in ipairs(tbl) do
        vals[value] = true
    end
    return vim.tbl_keys(vals)
end

---Add an abbreviated command such that it does not get replaced in other contexts
---http://vim.wikia.com/wiki/Replace_a_builtin_command_using_cabbrev
---@param new string
---@param old string
function M.addAbrev(new, old, opts)
    local range_regex = [[%(%([0-9]+)<Bar>%(''[^,]))]]
    local range_1_regex = [[\v^]] .. range_regex .. [[$]]
    local range_2_regex = [[\v^]] .. range_regex .. "," .. range_regex .. [[$]]

    if opts == nil then opts = {} end

    local test = [[getcmdtype()==':' && (getcmdpos()==1 ]]
    if opts.range1 then test = test .. " <Bar><Bar> (match(getcmdline(), '" .. range_1_regex .. "') == 0)" end
    if opts.range2 then test = test .. " <Bar><Bar> (match(getcmdline(), '" .. range_2_regex .. "') == 0)" end
    test = test .. ")"

    vim.cmd(
        "cabbrev " .. new .. " <c-r>" ..
        "=(" .. test .. " ? '" .. old .. "' : '" .. new .. "')<CR>"
    )
end

--- Get the number of selected lines
---@return number
function M.selectionSize()
    return vim.fn.line("'>") - vim.fn.line("'<") + 1
end

---@param lower number
---@param val number
---@param upper number
---@return number
function M.clamp(lower, val, upper)
    return math.max(lower, math.min(upper, val))
end

function M.startsWith(str, start)
    return str:sub(1, #start) == start
end

function M.endsWith(str, ending)
    return ending == "" or str:sub(- #ending) == ending
end

return M
