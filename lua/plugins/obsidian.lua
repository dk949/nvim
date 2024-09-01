-- epwalsh/obsidian.nvim
--
--
--

return {
    'epwalsh/obsidian.nvim',
    tag = "*",
    as = "obsidian",
    after = { "cmp" },
    requires = {
        -- Required.
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "cmp",
    },
    config = function()
        require("obsidian").setup {
            workspaces = _G.dk949.obsidian_worspaces,
            -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
            completion = {
                -- Set to false to disable completion.
                nvim_cmp = true,
                -- Trigger completion at 2 chars.
                min_chars = 0,
            },
            -------------------------------------------------------------
            callbacks = {
                post_set_workspace = function(client, workspace)
                    local norm_cwd = vim.fs.normalize(vim.fn.getcwd())
                    local norm_root = vim.fs.normalize(tostring(workspace.root))
                    if require("utils").startsWith(norm_cwd, norm_root) then vim.opt_local.conceallevel = 2 end
                end,
            },

        }
    end,
}
