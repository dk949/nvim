return {
    processor = "magick_cli",
    integrations = {
        markdown = {
            enabled = true,
            only_render_image_at_cursor = false,
        },
        neorg = {
            enabled = true,
            only_render_image_at_cursor = false,
            ---@param document_path string
            ---@param image_path string
            ---@param fallback fun(document_path:string,image_path:string):string
            ---@return string
            resolve_image_path = function(document_path, image_path, fallback)
                return fallback(document_path, image_path)
            end
        }
    }
}
