return {
    window = {
        open = "alternate"
    },
    hooks = {
        post_open = function ()
            require("flatten").config.window.open = "alternate"
        end
    },
}
