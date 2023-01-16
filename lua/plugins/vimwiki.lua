-- https://github.com/vimwiki/vimwiki
return {
    "vimwiki/vimwiki",
    config = function()
        vim.g.vimwiki_hl_headers = 1
        vim.g.vimwiki_create_link = 1
        vim.g.vimwiki_hl_cb_checked = 0
        vim.g.vimwiki_global_ext = 1
        vim.g.vimwiki_list_ignore_newline = 1
        vim.g.vimwiki_text_ignore_newline = 0
        vim.g.vimwiki_table_auto_fmt = 1
        vim.g.vimwiki_table_reduce_last_col = 1
        vim.g.vimwiki_html_header_numbering = 0
        vim.g.vimwiki_autowriteall = 1
        vim.g.vimwiki_toc_header_level = 2
        vim.g.vimwiki_toc_link_format = 0
        vim.g.vimwiki_auto_chdir = 1
        vim.g.vimwiki_links_header_level = 2
        vim.g.vimwiki_tags_header_level = 2
        vim.g.vimwiki_auto_header = 1

        vim.g.vimwiki_toc_header = 'Contents'
        vim.g.vimwiki_listsyms = ' ○◐●✓'
        vim.g.vimwiki_listsym_rejected ='✗'
        vim.g.vimwiki_folding = 'list'
        vim.g.vimwiki_dir_link = 'index'
        vim.g.vimwiki_html_header_numbering_sym = ''
        vim.g.vimwiki_links_header = 'Links'
        vim.g.vimwiki_tags_header = 'Tags'

        vim.g.vimwiki_ext2syntax = {['.mkdn'] = 'markdown',['.mdwn'] = 'markdown',['.mdown'] = 'markdown',['.markdown'] = 'markdown',['.mw'] = 'media'}

        vim.g.vimwiki_list = {{
            path = '~/Uni/wiki/text/',
            path_html = '~/Uni/wiki/html/',
            name = 'uni',
            auto_export = 1,
            auto_toc = 1,
            index = 'index',
            ext = '.wiki',
            syntax = 'default',
            links_space_char = '_',
            template_path = '~/Uni/wiki/templates/',
            template_default = 'base',
            template_ext = '.html',
            css_name = 'styles.css',
            maxhi = 1,
            automatic_nested_syntaxes = 1,
            list_margin = -1,
            auto_tags = 1,
            auto_generate_links = 1,
            auto_generate_tags = 1,
            exclude_files = {},
        }}
    end
}
