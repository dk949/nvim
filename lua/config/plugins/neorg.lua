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
        ["core.esupports.indent"] = {
            config = {
                format_on_enter = false,
                format_on_escape = false,
                indents = { ranged_verbatim_tag_content = 0 },
            }
        },
        ["core.export"] = {},
        ["core.dirman"] = {
            config = {
                workspaces = { notes = "~/Uni/notes/", womp = "~/Uni/code/xdsl/womp/notes" },
                default_workspace = "notes",
                open_last_workspace = false, -- maybe?
            },
        },
    }
}
