-- https://github.com/ap/vim-css-color.git,
return {
    "ap/vim-css-color",
    ft = require("lang_features").feat.color_on,
    config = function()
        vim.api.nvim_create_user_command("Csscolor", function(args)
            if args.bang then
                vim.fn["css_color#disable"]()
            else
                vim.fn["css_color#toggle"]()
            end
        end, { bang = true })
    end
}
