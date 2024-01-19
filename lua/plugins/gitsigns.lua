-- https://github.com/lewis6991/gitsigns.nvim
return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require('gitsigns').setup {
            signcolumn                   = false, -- Toggle with `:Gitsigns toggle_signs`
            numhl                        = true, -- Toggle with `:Gitsigns toggle_numhl`
            current_line_blame_opts      = {
                delay = 0,
                virt_text_pos = 'right_align', -- 'eol' | 'overlay' | 'right_align'
            },
            current_line_blame_formatter = '(<author_time:%Y-%m-%d>) <author>: <summary>',
        }
    end
}
