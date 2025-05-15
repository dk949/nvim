local keymap = require("config.keymap")
local maps = keymap.oil:transform(function(_, m)
    local mode
    if m.mode == "" then mode = nil else mode = m.mode end
    if mode or m.opts then
        return m.lhs, { m.rhs, mode = mode, opts = m.opts }
    else
        return m.lhs, m.rhs
    end
end)
return {
    -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
    skip_confirm_for_simple_edits = true,
    keymaps = maps,
    view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
        is_always_hidden = function(name, _) return name == ".." end,
    },
    float = {
        -- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        max_width = 0.5,
        max_height = 0.5,
        border = "rounded",
    },
}
