return {
    opts = {
        processor = "magick_cli",
        integrations = {
            markdown = {
                enabled = true,
                only_render_image_at_cursor = false,
            },
        }
    },
    cond = vim.fn.executable("magick") == 1,
}
