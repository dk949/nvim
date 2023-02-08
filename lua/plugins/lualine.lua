-- https://github.com/nvim-lualine/lualine.nvim
return {
    "nvim-lualine/lualine.nvim",
    requires = {
        "ryanoasis/vim-devicons",
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        local branch      = { 'branch' }
        local buffers     = {
            'buffers',
            show_filename_only   = true,
            show_modified_status = true,

            mode    = 0,
            symbols = {
                modified       = ' ✦',
                alternate_file = '# ',
            }
        }
        local diagnostics = { 'diagnostics' } -- diagnostics count from your preferred source
        local diff        = { 'diff' } -- git diff status
        local encoding    = { 'encoding' } -- file encoding
        local fileformat  = { 'fileformat', icons_enabled = true }
        local filename    = { 'filename', newfile_status = true, path = 1 }
        ---@diagnostic disable-next-line: unused-local
        local filesize    = { 'filesize' }
        local filetype    = { 'filetype', icon_only = false, colored = true }
        ---@diagnostic disable-next-line: unused-local
        local hostname    = { 'hostname' }
        local location    = { 'location' } -- location in file in line:column format
        local mode        = { 'mode' } -- vim mode
        local progress    = { 'progress' } -- %progress in file
        ---@diagnostic disable-next-line: unused-local
        local searchcount = { 'searchcount' } -- number of search matches when hlsearch is active
        local tabs        = { 'tabs' } -- shows currently available tabs
        ---@diagnostic disable-next-line: unused-local
        local windows     = { 'windows' } -- shows currently available windows
        local function getWords()
            if not (
                vim.bo.filetype == "md"
                    or vim.bo.filetype == "txt"
                    or vim.bo.filetype == "markdown"
                    or vim.bo.filetype == "vimwiki"
                ) then
                return ""
            end

            local words = vim.fn.wordcount().words
            local visWords = vim.fn.wordcount().visual_words
            if visWords ~= nil then
                return tostring(visWords) .. "w"
            else
                return tostring(words) .. "w"
            end
        end

        require('lualine').setup {
            options           = {
                icons_enabled        = true,
                theme                = 'auto',
                disabled_filetypes   = {
                    statusline = {},
                    winbar     = {},
                },
                ignore_focus         = {},
                always_divide_middle = true,
                globalstatus         = false,
                refresh              = {
                    statusline = 1000,
                    tabline    = 1000,
                    winbar     = 1000,
                }
            },
            sections          = {
                lualine_a = { mode },
                lualine_b = { branch, diff, diagnostics },
                lualine_c = { filename },
                lualine_x = { encoding, fileformat, filetype },
                lualine_y = { getWords, progress, },
                lualine_z = { location }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { filename },
                lualine_x = { location },
                lualine_y = {},
                lualine_z = {}
            },
            tabline           = {
                lualine_a = { buffers },
                lualine_z = { tabs }
            },
            inactive_winbar   = {},
            extensions        = {}
        }
    end
}
