local M = {}

local lsps = {}
local feat = require("lang_features.package")
local function _setup(lang)

    if vim.tbl_contains(feat.spell, lang) then
        vim.cmd [[set spell]]
    end

    if feat.wrap[lang] ~= nil then
        for _, opt in ipairs(feat.wrap[lang]) do
            if type(opt) == "string" then vim.cmd("set " .. opt)
            elseif type(opt) == "table" then
                for k, v in pairs(opt) do
                    vim.cmd("set " .. k .. "=" .. tostring(v))
                end
            else error("unsupported option type " .. type(opt))
            end
        end
    end

    if feat.formatoptions[lang] ~= nil then
        vim.cmd([[set formatoptions=]] .. feat.formatoptions[lang])
    end

    if vim.tbl_contains(feat.colorcolumn, lang) then
        vim.cmd [[set colorcolumn=+1]]
        vim.cmd [[highlight ColorColumn ctermbg=11 guibg=#3c73c3]]
    end

    if vim.tbl_contains(feat.trailingWS, lang) then
        -- No whitespace at the ned of lines
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            command = [[%s/\s\+$//e]],
        })
    end

    vim.cmd([[set signcolumn=]] .. (vim.tbl_contains(feat.signcolumn, lang) and "yes" or "no"))

    -- lsp
    vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "*",
        callback = function()
            if feat.lspconfig[lang] ~= nil then
                local capabilities = require("cmp_nvim_lsp").default_capabilities()
                feat.lspconfig[lang](capabilities, nil)
            end
        end
    })

    -- formatting
    dk949.fmtFn = feat.fmt[lang] or function() end
end

function M.setup()
    for lang, _ in pairs(feat.allLangs) do
        vim.api.nvim_create_autocmd("FileType", {
            pattern = lang,
            callback = function() _setup(lang) end,
        })
    end
end

M.feat = feat
return M
