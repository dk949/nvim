return {
    load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {
            config = {
                icons = { todo = { uncertain = { icon = "" } } },
            },
        },
        ["core.integrations.image"] = {},
        ["core.latex.renderer"] = {},
        ["core.export"] = {},
        ["core.dirman"] = {
            config = {
                workspaces = { notes = "~/Uni/notes/", },
                default_workspace = "notes",
                open_last_workspace = false, -- maybe?
            },
        },
    }
}
