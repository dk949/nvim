require("utils")

local function nop()end

local function common()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_gb"
    vim.opt_local.colorcolumn = "+1"
    vim.cmd[[highlight ColorColumn ctermbg=6]]
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.list = false
    vim.opt_local.textwidth = 80

    vim.keymap.set('n', 'j', "gj", {silent = true, buffer = true})
    vim.keymap.set('n', 'k', "gk", {silent = true, buffer = true})
    vim.keymap.set('n', 'gj', "j", {silent = true, buffer = true})
    vim.keymap.set('n', 'gk', "k", {silent = true, buffer = true})
end


local individual = {
    markdown = function()end,
    tex = function() end,
    vimwiki = function()end,
}



augroup("NonCodeGroup", {
    FileType = {
        pattern = dk949.noncodeft,
        callback = common,
    }
})

for _, lang in ipairs(dk949.noncodeft) do
    augroup(lang .. "Group", {
        FileType = {
            pattern = {lang},
            callback = individual[lang] or nop,
        }
    })
end
