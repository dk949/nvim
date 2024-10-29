local M = {}

local lsps = {}
local feat = require("lang_features.package")
local function _setup(lang)
    if vim.tbl_contains(feat.goyo_mode, lang) then
        vim.api.nvim_create_autocmd("User", {
            pattern = "GoyoLeave",
            callback = function()
                require('lualine').hide({ unhide = true })
            end,
            nested = true,
        })
        vim.api.nvim_create_autocmd("User", {
            pattern = "GoyoEnter",
            callback = function()
                require("lualine").hide();
                vim.opt_local.tabline = ""
            end,
            nested = true,
        })
    end

    if vim.tbl_contains(feat.spell, lang) then
        vim.opt_local.spell = true;
        vim.opt_local.spelllang = 'en_gb'
    end

    -- TODO(dk949): fix global set here
    if feat.wrap[lang] ~= nil then
        for _, opt in ipairs(feat.wrap[lang]) do
            if type(opt) == "string" then
                vim.cmd("set " .. opt)
            elseif type(opt) == "table" then
                for k, v in pairs(opt) do
                    vim.cmd("set " .. k .. "=" .. tostring(v))
                end
            else
                error("unsupported option type " .. type(opt))
            end
        end
    end

    if feat.tab[lang] ~= nil then
        vim.opt_local.tabstop = feat.tab[lang].len
        vim.opt_local.shiftwidth = feat.tab[lang].len
        vim.opt_local.softtabstop = feat.tab[lang].len
        vim.opt_local.expandtab = feat.tab[lang].expand
    end

    if feat.formatoptions[lang] ~= nil then
        vim.opt_local.formatoptions = feat.formatoptions[lang]
    end

    if vim.tbl_contains(feat.colorcolumn, lang) then
        vim.opt_local.colorcolumn = "+1"
        vim.cmd [[highlight ColorColumn ctermbg=11 guibg=#3c73c3]]
    end

    if vim.tbl_contains(feat.trailingWS, lang) then
        -- No whitespace at the ned of lines
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            command = [[%s/\s\+$//e]],
        })
    end

    vim.opt_local.signcolumn = (vim.tbl_contains(feat.signcolumn, lang) and "yes" or "no")
    if vim.tbl_contains(feat.logicalLines, lang) then
        vim.keymap.set({ 'v', 'n', 'o' }, "j", "gj", { silent = true, buffer = true })
        vim.keymap.set({ 'v', 'n', 'o' }, "gj", "j", { silent = true, buffer = true })
        vim.keymap.set({ 'v', 'n', 'o' }, "k", "gk", { silent = true, buffer = true })
        vim.keymap.set({ 'v', 'n', 'o' }, "gk", "k", { silent = true, buffer = true })

        vim.keymap.set({ 'v', 'n', 'o' }, "0", "g0", { silent = true, buffer = true })
        vim.keymap.set({ 'v', 'n', 'o' }, "$", "g$", { silent = true, buffer = true })
        vim.keymap.set({ 'v', 'n', 'o' }, "g0", "0", { silent = true, buffer = true })
        vim.keymap.set({ 'v', 'n', 'o' }, "g$", "$", { silent = true, buffer = true })

        vim.keymap.set('n', "A", "g$a", { silent = true, buffer = true })
        vim.keymap.set('n', "gA", "A", { silent = true, buffer = true })
        vim.keymap.set('n', "I", "g0i", { silent = true, buffer = true })
        vim.keymap.set('n', "gI", "I", { silent = true, buffer = true })
    end

    local capabilities = nil
    local on_attach = nil
    local function cap_on_attach()
        if capabilities == nil then
            capabilities = require("cmp_nvim_lsp").default_capabilities()
        end
        if on_attach == nil then
            on_attach = function(client, bufnr)
                if client.server_capabilities.documentSymbolProvider then
                    require("nvim-navic").attach(client, bufnr)
                end
                vim.lsp.inlay_hint.enable()
            end
        end
        return capabilities, on_attach
    end

    -- lsp
    vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "*",
        callback = function()
            if feat.lspconfig[lang] ~= nil then
                require "lang_features.snippets" (lang);
                local cap, on_a = cap_on_attach()
                feat.lspconfig[lang](cap, on_a)
            end
        end
    })

    -- formatting
    if dk949.fmtFn == nil then dk949.fmtFn = {} end
    dk949.fmtFn[vim.fn.bufnr()] = feat.fmt[lang] or function() end
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
