" Configuration for vimwiki


augroup wiki_session
    autocmd!
    " Use spell checker with vimwiki
    autocmd FileType vimwiki setlocal spell spelllang=en_gb
    " Insert an image with <leader>vi
    autocmd FileType vimwiki nnoremap <buffer> <leader>vi :WikiInsertImage
    " Take a screenshot and insert it with <leader>vg
    autocmd FileType vimwiki nnoremap <buffer> <leader>vg :WikiGetImage
    " Surround selected with dollar signs
    autocmd FileType vimwiki vnoremap <leader>vlm :call InlineLatexVisual()<CR>
    " Surround the current character with dollar signs
    autocmd FileType vimwiki nnoremap <leader>vlm :call InlineLatexNormal()<CR>
    " Insert a \text{}
    autocmd FileType vimwiki nnoremap <leader>vlt :call TextInLatexNormal()<CR>
    " Surround selected text with \text{ }
    autocmd FileType vimwiki vnoremap <leader>vlt :call TextInLatexVisual()<CR>
    " Moving up and down moves visually by lines, not by actual lines
    autocmd FileType vimwiki call RemapMovement()
augroup END


" Local options set for uni_wiki
let uni_wiki = {}
let uni_wiki.path = '~/Uni/wiki/text/'
let uni_wiki.path_html = '~/Uni/wiki/html/'
let uni_wiki.name = 'uni'
let uni_wiki.auto_export = 1
let uni_wiki.auto_toc = 1
let uni_wiki.index = 'index'
let uni_wiki.ext = '.wiki'
let uni_wiki.syntax = 'default'
let uni_wiki.links_space_char = '_'
let uni_wiki.template_path = '~/Uni/wiki/templates/'
let uni_wiki.template_default = 'base'
let uni_wiki.template_ext = '.html'
let uni_wiki.css_name = 'styles.css'
let uni_wiki.maxhi = 1
let uni_wiki.automatic_nested_syntaxes = 1
let uni_wiki.list_margin = -1
let uni_wiki.auto_tags = 1
let uni_wiki.auto_generate_links = 1
let uni_wiki.auto_generate_tags = 1
let uni_wiki.exclude_files = []


" Local options set for vimwiki_docs
let vimwiki_docs = {}
let vimwiki_docs.path = '~/Documents/vimwiki_docs/vimwiki/'
let vimwiki_docs.path_html = '~/Documents/vimwiki_docs/vimwiki_html/'
let vimwiki_docs.name = 'vimwiki_docs'
let vimwiki_docs.auto_export = 1
let vimwiki_docs.auto_toc = 1
let vimwiki_docs.index = 'index'
let vimwiki_docs.ext = '.wiki'
let vimwiki_docs.syntax = 'default'
let vimwiki_docs.links_space_char = '_'
let vimwiki_docs.template_path = '~/Documents/vimwiki_docs/vimwiki_template/'
let vimwiki_docs.template_default = 'base'
let vimwiki_docs.template_ext = '.html'
let vimwiki_docs.css_name = 'styles.css'
let vimwiki_docs.maxhi = 1
let vimwiki_docs.automatic_nested_syntaxes = 1
let vimwiki_docs.list_margin = -1
let vimwiki_docs.auto_tags = 1
let vimwiki_docs.auto_generate_links = 1
let vimwiki_docs.auto_generate_tags = 1
let vimwiki_docs.exclude_files = []



" Global options set for all wikis
let g:vimwiki_hl_headers = 0
let g:vimwiki_hl_cb_checked = 0
let g:vimwiki_global_ext = 1
let g:vimwiki_listsyms = ' ○◐●✓'
let g:vimwiki_listsym_rejected ='✗'
let g:vimwiki_folding = 'list'
let g:vimwiki_list_ignore_newline = 1
let g:vimwiki_text_ignore_newline = 0
let g:vimwiki_create_link = 1
let g:vimwiki_table_auto_fmt = 1
let g:vimwiki_table_reduce_last_col = 1
let g:vimwiki_dir_link = 'index'
let g:vimwiki_html_header_numbering = 0
let g:vimwiki_html_header_numbering_sym = ''
let g:vimwiki_autowriteall = 1
let g:vimwiki_toc_header = 'Contents'
let g:vimwiki_toc_header_level = 2
let g:vimwiki_toc_link_format = 0
let g:vimwiki_auto_chdir = 1
let g:vimwiki_links_header = 'Links'
let g:vimwiki_links_header_level = 2
let g:vimwiki_tags_header = 'Tags'
let g:vimwiki_tags_header_level = 2
let g:vimwiki_auto_header = 1
let g:vimwiki_ext2syntax = {'.mkdn': 'markdown', '.mdwn': 'markdown', '.mdown': 'markdown',  '.markdown': 'markdown', '.mw': 'media'}

" Registering all wikis
let g:vimwiki_list = [uni_wiki,{}]



" Takes the name of a file and inserts that image into the current buffer
function! WikiInsertImageFunc(img)
    let l:imageName = join(split(a:img, " "), '_')
    exe 'norm i{{local:../images/' . l:imageName . '.png|' . a:img . '|style="width:50%;height:auto;"}}'
endfunc

" Takes a screenshot, saves it and inserts it into the current buffer
function! WikiGetImageFunc(img)
    let l:imageName = join(split(a:img, " "), '_')
    exe '!killall unclutter'
    exe '!import ~/Uni/wiki/images/' . l:imageName . '.png'
    exe 'norm i{{local:../images/' . l:imageName . '.png|' . a:img . '|style="width:50%;height:auto;"}}'
    exe '!unclutter -b'
endfunc

" command interfaces for the above functions
command! -nargs=1 WikiInsertImage :call WikiInsertImageFunc(<f-args>)
command! -nargs=1 WikiGetImage :call WikiGetImageFunc(<f-args>)


" If text on a single line is selected, surround it with dollar signs. If multiple lines are selected, surround them with {{$ }}$
function! InlineLatexVisual() range
    let markers = [getpos("'>"), getpos("'<")]

    if markers[0][1] == markers[1][1]
        let commands = ["norm! a$", "norm! i$" ]
    else
        let commands = ["norm! o}}$" , "norm! O{{$"]
    endif

    for i in [0, 1]
        call setpos(".", markers[i])
        exe commands[i]
    endfor
endfunction


function! InlineLatexNormal()
    :norm! i$
    :norm! la$
endfunction

function! TextInLatexNormal()
    :norm! i\text{  }
    :norm! h
    :startinsert
endfunction

function! TextInLatexVisual() range
    let markers = [getpos("'>"), getpos("'<")]
    let commands = ["norm! a }", "norm! i\\text{ " ]

    for i in [0, 1]
        call setpos(".", markers[i])
        exe commands[i]
    endfor
    :norm f}l
endfunction

" TODO, add = as a text object

function! RemapMovement()
    nnoremap j gj
    nnoremap gj j

    nnoremap k gk
    nnoremap gk k
endfunction


" FIXME
function! MakeWikiLinkVisual() range
    let markers = [getpos("'>"), getpos("'<")]
    let saved = @0
    norm y`<v`>
    :VimwikiFollowLink
    norm f]i|
    norm p
    let @0 = saved
endfunction
