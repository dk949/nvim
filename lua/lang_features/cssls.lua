local settings = {
    validate = false,
    unknownAtRules = "ignore",
}
return require("utils").makeDefaultLspCounfig("cssls",
    {
        settings = {
            css  = settings,
            less = settings,
            scss = settings,
        }
    }
)
