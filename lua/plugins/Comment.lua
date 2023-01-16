-- https://github.com/numToStr/Comment.nvim

return {
    "numToStr/Comment.nvim",
    config = function()
        require('Comment').setup {
            ---Add a space b/w comment and the line
            padding = true,
            ---LHS of toggle mappings in NORMAL mode
            toggler = {
                ---Line-comment toggle keymap
                line = '<space>/',
            },
            ---LHS of operator-pending mappings in NORMAL and VISUAL mode
            opleader = {
                ---Block-comment keymap
                block = '<space>/',
            },
            ---LHS of extra mappings
            extra = {
                ---Add comment at the end of line
                eol = '<space>?',
            },
            ---Enable keybindings
            ---NOTE: If given `false` then the plugin won't create any mappings
            mappings = {
                basic = true,
                extra = true,
            },
            ---Function to call before (un)comment
            pre_hook = nil,
            ---Function to call after (un)comment
            post_hook = nil,
        }
    end
}
