return {
    filetypes = { "*" },          -- Filetype options.  Accepts table like `user_default_options`
    buftypes = {},                -- Buftype options.  Accepts table like `user_default_options`
    -- Boolean | List of usercommands to enable.  See User commands section.
    user_commands = true,         -- Enable all or some usercommands
    lazy_load = false,            -- Lazily schedule buffer highlighting setup function
    user_default_options = {
        css = true,          -- Enable all CSS *features*:
        -- names, RGB, RGBA, RRGGBB, RRGGBBAA, AARRGGBB, rgb_fn, hsl_fn
        css_fn = true,       -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Tailwind colors.  boolean|'normal'|'lsp'|'both'.  True sets to 'normal'
        tailwind = 'both',    -- Enable tailwind colors
        tailwind_opts = { update_names = true, },
        mode = "virtualtext", -- Set the display mode
        -- Virtualtext character to use
        virtualtext = "■",
        -- Display virtualtext inline with color.  boolean|'before'|'after'.  True sets to 'after'
        virtualtext_inline = 'after',
        -- Virtualtext highlight mode: 'background'|'foreground'
        virtualtext_mode = "foreground",
    },

}
