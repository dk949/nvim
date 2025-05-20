local M = {}
local utils = require("utils")
local log = require("utils.log")

---@alias Rhs string|function

---@alias With (table<string,Rhs>)|(fun(name:string):Rhs?)

---@class Mapping
---@field mode string|string[]
---@field lhs string|string
---@field rhs Rhs
---@field opts table?


---@class MappingGroup
---@field private [1] table<string, Mapping>
---Creates a mapping in the `MappingGroup`
---All arguments are the same as for `vim.keymap.set`, except:
---* `opts` can be a string, it is used as a description in that case
---* An optional `name` can be supplied as the last argument, see `defaultApply` for details
---
---A `MappingGroup` cannot  have two mappings with the same name (raises a warning).
---When `name` is not specified, a combination of `mode` and `lhs` is used.
---@field map fun(self, mode: string|string[], lhs: string, rhs: Rhs, opts: (string|table)?, name: string?): MappingGroup
---General version of `map`.
---
---This is identical to `map`, except it doesn't automatically set the `opts`
---to be suitable for use with `vim.keymap.set`. This way `opts` can be used
---for any plugin specific options.
---`opts` has to be a `table` or `nil`
---@field gmap fun(self, mode: string|string[], lhs: string, rhs: Rhs, opts: table?, name: string?): MappingGroup
---Creates a mapping for when the popup menu is active.
---This acts as an insert mode mapping with `expr` setting
---If popup menu is not visible, `lhs` is used directly, if it is `rhs` is used
---
---If `rhs` is a list, the first element is used when popup menu is not visible
---and second when it is. This is useful when the meaning of the key binding
---needs to change both when the menu is visible and when it is not.
---@field pummap fun(self, lhs:string, rhs: Rhs|[Rhs, Rhs], opts: (string|table)?, name: string?): MappingGroup
---Creates a mapping with a missing `rhs`
---When creating this type of mapping `name` is required.
---
---This is intended for mappings where only `lhs` is known at the time when the
---mapping is defined. The mapping has to be accessed by name through one of
---the `*[Aa]pply*` functions (see below).
---NOTE: `opts` can be used to store additional (e.g. plugin specific) information.
---@field partial fun(self, mode: string|string[], lhs: string, name: string, opts: (string|table)?): MappingGroup
---unmaps a key binding
---@field unmap fun(self, mode: string|string[], lhs: string): MappingGroup
---Calls `fn` for every mapping.
---This is intended as a low level API where the calee determines how to handle
---the `name` and any missing `rhs`s.
---@field apply fun(self, fn: fun(name: string, m: Mapping)):nil
---Just like `apply`, but collects the results of `fn` for each mapping in a table.
---If `fn` returns two values, the first is used as the key and second as the value,
---otherwise value is just inserted in the table.
---@field transform fun(self, fn: fun(name: string, m: Mapping):any,(any?)):table
---Calls `vim.keymap.set` with each mapping.
---Optionally, a `with` `table` or `function` can be provided which maps a
---`name` to an `Rhs`.
---
---If `with` is not `nil`, it takes priority over the stored `rhs`. If `name`
---is not in the table or function returns `nil`, the stored `rhs` is used.
---
---If `rhs` is nil (stored or provided by `with`) the keymap is not set and no
---warning is given.
---@field defaultApply fun(self, with: With?):nil
---Same as `defaultApply`, but is only set when `event` (or one of `event`s if table) is fired.
---`pattern` is used as the pattern in the autocmd.
---@field defaultApplyOn fun(self, event:string|string[], pattern:(string|string[])?, with: With?):nil


---@param mode string|string[]
---@param lhs string
---@return string
local function makeName(mode, lhs)
    if type(mode) == "string" then return mode .. ' ' .. lhs end
    return vim.iter(mode):join(',') .. ' ' .. lhs
end

---@return MappingGroup
function M.newMapGroup()
    local map_group = { {} }
    ---@cast map_group MappingGroup

    function map_group:map(mode, lhs, rhs, opts, name)
        if type(opts) == "string" then
            opts = { desc = opts }
        elseif not opts then
            opts = {}
        end

        if opts.silent == nil then opts.silent = false end
        return self:gmap(mode, lhs, rhs, opts, name)
    end

    function map_group:gmap(mode, lhs, rhs, opts, name)
        if not name then name = makeName(mode, lhs) end
        if self[1][name] then log.warn("Key binding " .. name " already exists") end
        self[1][name] = {
            mode = mode,
            lhs  = lhs,
            rhs  = rhs,
            opts = opts,
        }
        return self
    end

    function map_group.partial(self, mode, lhs, name, opts)
        ---@diagnostic disable-next-line: param-type-mismatch -- this is fine
        return self:map(mode, lhs, nil, opts, name)
    end

    function map_group:pummap(lhs, rhs, opts, name)
        if type(opts) == "string" then
            opts = { desc = opts }
        elseif opts == nil then
            opts = {}
        end
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
        end, opts, name)
        return self
    end

    function map_group:unmap(mode, lhs)
        ---@diagnostic disable-next-line: param-type-mismatch -- this is also fine
        return self:gmap(mode, lhs, nil, { __unmap = true })
    end

    function map_group:apply(fn)
        for name, p in pairs(self[1]) do fn(name, p) end
    end

    function map_group:transform(fn)
        local out = {}
        for name, p in pairs(self[1]) do
            local k, v = fn(name, p)
            if v ~= nil then
                out[k] = v
            else
                table.insert(out, k)
            end
        end
        return out
    end

    function map_group:defaultApply(with)
        if with then
            for name, p in pairs(self[1]) do
                local rhs = utils.fnOrTable(with, name) or p.rhs
                if rhs then
                    vim.keymap.set(p.mode, p.lhs, rhs, p.opts)
                elseif p.opts.__unmap then
                    vim.keymap.del(p.mode, p.lhs)
                end
            end
        else
            for _, p in pairs(self[1]) do
                if p.rhs then
                    vim.keymap.set(p.mode, p.lhs, p.rhs, p.opts)
                elseif p.opts.__unmap then
                    vim.keymap.del(p.mode, p.lhs)
                end
            end
        end
    end

    function map_group:defaultApplyOn(event, pattern, with)
        local event_name = event
        if type(event) == "table" then event_name = vim.iter(event):join("_") end
        utils.withAugroup("keymap_apply_on_" .. event_name, function(grp)
            vim.api.nvim_create_autocmd(event, {
                pattern = pattern,
                callback = function() self:defaultApply(with) end,
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

function M.formatFile()
    utils.withWin(function()
        vim.cmd "keepjumps norm! gggqG"
    end)
end

return M
