" Sourced using an autocmd instead of through packer

" Supposed to disable table formatting but it doesn't seem to work
"let g:vimwiki_table_mappings=0
"let g:vimwiki_table_auto_fmt=0
"let g:vimwiki_table_reduce_last_col=0

let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:vimwiki_list = [
            \ {'path': '~/Documents/self-actualisation', 'syntax': 'markdown', 'ext': '.md', 'auto_diary_index': 1},
            \ {'path': '~/Documents/school',             'syntax': 'markdown', 'ext': '.md'},
            \ {'path': '~/Documents/leisure',            'syntax': 'markdown', 'ext': '.md'},
            \ {'path': '~/Documents/tech',               'syntax': 'markdown', 'ext': '.md'},
            \ {'path': '~/Documents/misc',               'syntax': 'markdown', 'ext': '.md'},
            \ ]
