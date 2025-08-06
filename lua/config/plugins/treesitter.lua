local ignore = { "apex", "authzed", "bass", "beancount", "bitbake", "blade", "blueprint", "bp", "brightscript",
    "caddy", "capnp", "chatito", "circom", "cooklang", "corn", "cpon", "cue", "cylc", "djot", "dtd",
    "earthfile", "ebnf", "eds", "eex", "elsa", "elvish", "enforce", "facility", "faust", "fennel", "fidl",
    "firrtl", "fsh", "func", "fusion", "GAP system", "GAP system test files", "Glimmer and Ember",
    "glimmer_javascript", "glimmer_typescript", "GN", "goctl", "gren", "gstlaunch", "hare", "hcl", "heex",
    "helm", "hjson", "hlsplaylist", "hocon", "hoon", "hurl", "hyprlang", "inko", "ipkg", "ispc", "janet_simple",
    "just", "kcl", "kconfig", "kdl", "koto", "kusto", "lalrpop", "leo", "menhir", "nqc", "nu",
    "Path of Exile item filter", "pioasm", "po", "pod", "problog", "promql", "prql", "psv", "ralph", "rasi",
    "razor", "rbs", "re2c", "rescript", "rnoweb", "runescript", "scfg", "sflog", "slang", "slim", "slint",
    "smali", "smithy", "soql", "sosl", "sourcepawn", "starlark", "supercollider", "superhtml", "surface",
    "sxhkdrc", "systemtap", "t32", "tact", "teal", "thrift", "tiger", "tlaplus", "tsx", "turtle", "twig",
    "typespec", "typoscript", "ungrammar", "unison", "usd", "uxn tal", "vento", "vhs", "vrl", "wing", "wit",
    "yang", "yuck", "ziggy", "ziggy_schema", }

return function()
    require("nvim-treesitter.configs").setup
    {
        ensure_installed = "all",
        ignore_install = ignore,
    }
end
