local keymap = require("config.keymap").telescope
local mappings = { n = {}, i = {} }
keymap:apply(function(_, mapping)
    local mode
    if type(mapping.mode) == "string" then
        mode = { mapping.mode }
    else
        mode = mapping.mode
    end
    ---@cast mode string[]
    for _, m in ipairs(mode) do
        assert(m == 'n' or m == 'i', "Expected normal or insert mode")
        mappings[m][mapping.lhs] = mapping.rhs
    end
end)
return {
    defaults = {
        prompt_prefix = "❯ ",
        selection_caret = "-> ",
        mappings = mappings,
    }
}
