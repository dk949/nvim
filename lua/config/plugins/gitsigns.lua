return {
    signcolumn = false,
    numhl = true,
    current_line_blame_opts = {
        delay = 0,
        virt_text_pos = 'right_align', -- 'eol' | 'overlay' | 'right_align'
    },
    current_line_blame_formatter = '(<author_time:%Y-%m-%d>) <author>: <summary>',
    on_attach = function(bufnr)
        local gs = require("gitsigns")
        require("config.keymap").gitsigns:defaultApply(function(_, fn) return function() fn(gs) end end, bufnr)
    end,
}
