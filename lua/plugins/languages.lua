return {

    -- D (https://github.com/idanarye/vim-dutyl)
    {
        "idanarye/vim-dutyl",
        init = function()
            vim.g.dutyl_dontHandleFormat = true
            vim.g.dutyl_neverAddClosingParen = true
        end,
        ft = "d",
        config = function() vim.cmd [[DUDCDstartServer]] end
    },

    -- D (https://github.com/dk949/serve-d-utils)
    {
        "dk949/serve-d-utils",
        ft = { "d" },
    },

    -- Haskell (https://github.com/neovimhaskell/haskell-vim)
    {
        "neovimhaskell/haskell-vim",
        ft = "haskell",
        init = function()
            vim.g.haskell_backpack = 1                -- to enable highlighting of backpack keywords
            vim.g.haskell_classic_highlighting = 0    -- more traditional highlighting
            vim.g.haskell_enable_arrowsyntax = 1      -- to enable highlighting of `proc`
            vim.g.haskell_enable_pattern_synonyms = 1 -- to enable highlighting of `pattern`
            vim.g.haskell_enable_quantification = 1   -- to enable highlighting of `forall`
            vim.g.haskell_enable_recursivedo = 1      -- to enable highlighting of `mdo` and `rec`
            vim.g.haskell_enable_static_pointers = 1  -- to enable highlighting of `static`
            vim.g.haskell_enable_typeroles = 1        -- to enable highlighting of type roles
        end
    },

    -- LLVM (https://github.com/rhysd/vim-llvm)
    {
        "rhysd/vim-llvm",
        init = function()
            vim.g.llvm_ext_no_mapping = true
        end
    },

    -- PDF (https://github.com/dk949/pdf.vim)
    { "dk949/pdf.vim",              ft = "pdf" },

    -- plantuml (https://github.com/aklt/plantuml-syntax)
    { "aklt/plantuml-syntax" },

    -- rust (https://github.com/rust-lang/rust.vim)
    { "rust-lang/rust.vim",         ft = "rust" },

    -- glsl (https://github.com/tikhomirov/vim-glsl)
    { "tikhomirov/vim-glsl" },

    -- pegd (https://github.com/dk949/pegged.vim)
    { 'dk949/pegged.vim' },

    -- lark (https://github.com/lark-parser/vim-lark-syntax)
    { 'lark-parser/vim-lark-syntax' },

    -- pegd (https://github.com/dk949/asterisp.vim)
    { 'dk949/asterisp.vim' },
}
