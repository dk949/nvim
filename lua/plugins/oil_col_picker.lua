local action_state = require "telescope.actions.state"
local actions      = require "telescope.actions"
local conf         = require "telescope.config".values
local finders      = require "telescope.finders"
local oil          = require "oil"
local oil_conf     = require "oil.config"
local pickers      = require "telescope.pickers"
local utils        = require "utils"
---Get the name of a column spec
---@param spec oil.ColumnSpec
---@return string
local function getSpecName(spec)
    if type(spec) == "string" then
        return spec
    else
        return spec[1]
    end
end

local Action = {
    INSERT = 0,
    DELETE = 1,
}

local function findIndex(this_spec, col_specs)
    local conf_idx = 1
    for _, value in ipairs(col_specs) do
        if vim.deep_equal(this_spec, value) then
            if vim.deep_equal(oil_conf.columns[conf_idx], value) then
                return conf_idx, Action.DELETE
            else
                return conf_idx, Action.INSERT
            end
        else
            if vim.deep_equal(oil_conf.columns[conf_idx], value) then
                conf_idx = conf_idx + 1
            end
        end
    end
end

return function(col_spec, opts)
    col_spec = col_spec or {
        "icon", "type", "size", "permissions", "ctime", "mtime", "atime", "birthtime"
    }
    opts = require("telescope.themes").get_dropdown(opts)

    local finder = finders.new_table({
        results = col_spec,
        entry_maker = function(line)
            local display = function(tbl)
                local spec_name = getSpecName(tbl.value)
                if vim.tbl_contains(oil_conf.columns, function(value) return spec_name == getSpecName(value) end, { predicate = true }) then
                    return " " .. spec_name
                else
                    return "󰄱 " .. spec_name
                end
            end

            return {
                value = line,
                display = display,
                ordinal = utils.algo.findIf(col_spec, function(v) return vim.deep_equal(v, line) end),
            }
        end,
    })

    pickers.new(opts, {
        prompt_title = "Columns",
        finder = finder,
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, _)
            ---@type Picker
            local this = action_state.get_current_picker(prompt_bufnr)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                local copy = vim.deepcopy(oil_conf.columns)
                local idx, action = findIndex(selection.value, col_spec)
                if action == Action.INSERT then
                    table.insert(copy, idx, selection.value)
                else
                    table.remove(copy, idx)
                end
                oil.set_columns(copy)
                -- telescope needs to be closed when changing the columns, otherwise oil throws an error.
                -- Without this delay it reopens too quickly (set_columns is async and doesn't finish before
                -- `find` is called).
                vim.defer_fn(function() this:find() end, 100 --[[ms]])
            end)
            return true
        end
    }):find()
end
