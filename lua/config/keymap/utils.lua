local M = {}
local utils = require("utils")

---@class Mapping
---@field mode string|string[]
---@field lhs string|string
---@field rhs string|function
---@field opts table?

---@class MappingGroup
---@field [1] Mapping[]
---@field map fun(self, mode: string|string[], lhs: string, rhs: string|function, opts: (string|table)?): MappingGroup
---@field pummap fun(self, lhs:string, rhs: string|function|(string|function)[], opts: (string|table)?): MappingGroup
---@field apply fun(self, fn: fun(m: Mapping)):nil
---@field defaultApply fun(self):nil
---@field defaultApplyOn fun(self, event:string|string[], pattern:(string|string[])?):nil

---@return MappingGroup
function M.newMapGroup()
    local map_group = { {} }
    ---@cast map_group MappingGroup
    function map_group:map(mode, lhs, rhs, opts)

        if type(opts) == "string" then opts = { desc = opts }
        elseif opts == nil then opts = {} end

        if opts.silent == nil then opts.silent = false end
        table.insert(self[1], {
            mode = mode,
            lhs  = lhs,
            rhs  = rhs,
            opts = opts,
        })
        return self
    end

    function map_group:pummap(lhs, rhs, opts)
        if type(opts) == "string" then opts = { desc = opts }
        elseif opts == nil then opts = {} end
        opts.expr = true
        self:map("i", lhs, function()
            if type(rhs) == "table" then
                lhs = rhs[1]
                rhs = rhs[2]
            end
            if vim.fn.pumvisible() ~= 0 then
                return utils.fnOrVal(rhs)
            else
                return utils.fnOrVal(lhs)
            end
        end, opts)
        return self
    end

    function map_group:apply(fn)
        for _, p in ipairs(self[1]) do fn(p) end
    end

    function map_group:defaultApply()
        for _, p in ipairs(self[1]) do vim.keymap.set(p.mode, p.lhs, p.rhs, p.opts) end
    end

    function map_group:defaultApplyOn(event, pattern)
        local event_name = event
        if type(event) == "table" then event_name = vim.iter(event):join("_") end
        utils.withAugroup("keymap_apply_on_" .. event_name, function(grp)
            if pattern == nil then pattern = "*" end
            vim.api.nvim_create_autocmd(event, {
                pattern = pattern,
                callback = function() self:defaultApply() end,
                group = grp,
            })
        end)
    end

    return map_group
end

---@param name string
---@return fun():nil
function M.todo(name)
    return function()
        local comment = vim.o.commentstring:format("TODO(" .. name .. "):")
        vim.cmd.norm { "A" .. comment .. " ", bang = true }
        vim.cmd.startinsert { bang = true }
    end
end

return M
