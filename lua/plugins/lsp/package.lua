local packer = require("packer")

local ft = (function()
    local out = {}
    for key, _ in pairs(require("lang_features").feat.lspconfig) do
        table.insert(out, key)
    end
    return out
end)()

local utils = require("utils")
local localRequire = utils.makeLocalRequire [[plugins.lsp]]
local localUse = function(plug)
    return packer.use(localRequire(plug))
end

return function()
    localUse "LuaSnip"
    localUse "friendly_snippets"
    localUse "nvim_cmp"
    localUse "cmp_nvim_lsp"
    localUse "cmp_luasnip"
    localUse "cmp_buffer"
    localUse "cmp_path"
    localUse "lspconfig"
    localUse "mason"
    localUse "mason_lspconfig"
    localUse "neodev"
    localUse "trouble"
    localUse "cxx_heighlight"
end
