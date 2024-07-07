return require("utils").makeDefaultLspCounfig("tailwindcss", {
    settings = {
        tailwindCSS = {
            classAttributes = {
                "class",
                "className",
                "ngClass",
                "class:list",
                "style",
            }
        }
    }
})
