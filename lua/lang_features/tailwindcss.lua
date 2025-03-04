return require("utils").makeDefaultLspCounfig("tailwindcss", {
    filetypes = { "aspnetcorerazor", "astro", "astro-markdown", "blade", "clojure", "django-html", "htmldjango", "edge",
        "eelixir", "elixir", "ejs", "erb", "eruby", "gohtml", "gohtmltmpl", "haml", "handlebars", "haskell", "hbs",
        "html", "htmlangular", "html-eex", "heex", "jade", "leaf", "liquid", "markdown", "mdx", "mustache", "njk",
        "nunjucks", "php", "razor", "slim", "twig", "css", "less", "postcss", "sass", "scss", "stylus", "sugarss",
        "javascript", "javascriptreact", "reason", "rescript", "typescript", "typescriptreact", "vue", "svelte", "templ" },
    settings = {
        tailwindCSS = {
            classAttributes = {
                "class",
                "className",
                "ngClass",
                "class:list",
                "style",
            },
            -- includeLanguages = { haskell = "html" },
            experimental = {
                classRegex = { "class_ \"([^\"]*)", [[className\s*=\s*["'`]([^"'`]*)]] },
            },
        }
    }
})
