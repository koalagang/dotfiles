"  \##|   |
"##\\ |   |
"   \\|   \'---'/   Dante (koalagang)
"    \   _'.'O'.'   https://github.com/koalagang
"     | :___   \    (╯°□°）╯︵ sɔɐɯ ǝ
"     |  _| :  |
"     | :__,___/    "I plan to port this to lua and also to modularise it."
"     |   |
"     |   |
"     |   |
"     |   |
" WORK IN PROGRESS
" Porting config to lua
lua require 'init'
" During this process,
" instead of removing viml lines, I will comment them out.

"---Basics
"let mapleader = ','
"set number relativenumber
"set tabstop=4 softtabstop=0 shiftwidth=4 expandtab autoindent smartindent
"set smartcase ignorecase
"set nobackup noswapfile lazyredraw
"set cursorline
"set nocompatible
"filetype plugin on
"syntax on
hi CursorLine   cterm=NONE ctermbg=black
hi CursorColumn cterm=NONE ctermbg=black
"nno <silent> cc :set cursorcolumn!<cr>
"nno W :w<cr>
"nno <silent> <space> :noh<cr>
"vn < <gv
"vn > >gv
"nno n nzzzv
"nno N Nzzzv
"nno r <c-r>
"nno <silent> <leader>iv :edit ~/.config/nvim/init.vim<cr>
" Automatically enter insert mode when opening an empty file
autocmd BufNewFile * startinsert
autocmd VimEnter * if empty(expand("%")) | startinsert | endif
autocmd VimEnter * if getfsize(expand("%")) == 0 | startinsert | endif

" Line manipulation
"nno <m-k> ddkkp
"nno <m-j> ddp
" Register A
"vno y "ay
"vno d "ad
"nno p "ap
"nno yy "ayy
"nno dd "add
"" Register B
"vno Y "by vno D "bd
"nno P "bp
"nno YY "byy
"nno DD "bdd
" System register (register +)
" NOTE: to interact with the system register, you must have 'xclip' installed
" NOTE: use ctrl-q to enter visual block mode (instead of ctrl-v)
"vn <c-c> "+y
"vn <c-x> "+d
"no <c-v> "+p
"nno <c-c> "+yy
"nno <c-x> "+dd

"--Plugins
"call plug#begin()
"Plug 'vimwiki/vimwiki'
"Plug 'Yggdroot/indentLine'
"Plug 'ap/vim-css-color'
" Plugin which adds support for GDscript and running the Godot Engine directly from Vim
"Plug 'habamax/vim-godot'
"call plug#end()

" Plug commands
":PlugInstall   - installs plugins
":PlugUpdate    - updates plugins
":PlugDiff      - shows changes (after running :PlugUpdate)
":PlugClean     - remove plugins (first remove or comment them out and then restart vim)
"To rollback to an older version of a plugin, run :PlugDiff and then press 'X' on the respective version.

" Vim Wiki
"let g:vimwiki_global_ext = 0
"let g:vimwiki_list = [{'path': '~/Documents/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
"let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

" Indent line
"let g:indentLine_setConceal = 1
"let g:indentLine_conceallevel = 1
"let g:indentLine_concealcursor = "n"

" Godot (game engine)
"nno <buffer> grl :GodotRunLast<CR>
"nno <buffer> grr :GodotRun<CR>
"nno <buffer> grc :GodotRunCurrent<CR>
"nno <buffer> grf :GodotRunFZF<CR>

" Spellcheck
"set spelllang=en_gb,nb_no
"nno ss :set spell!<cr>
"nno sgb :setlocal spell! spelllang=en_gb!<cr>
"nno sus :set spell! spelllang=en_us!<cr>
"nno sno :set spell! spelllang=nb_no!<cr><cr>
"nno } ]s
"nno { [s

"---Tidying
"Convert text to UTF-8 and fileformat to Unix
setglobal termencoding=utf-8 fileencodings=
scriptencoding utf-8
"set encoding=utf-8
autocmd BufNewFile,BufRead  *    try
autocmd BufNewFile,BufRead  *    set encoding=utf-8
autocmd BufNewFile,BufRead  *    endtry
set fileformat=unix
"Clean up trailing spaces and single lines at the end of files
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e
autocmd BufWritePre *.[ch] %s/\%$/\r/e


"---Appearance
" Colours
highlight LineNr           ctermfg=5    ctermbg=none    cterm=none
highlight CursorLineNr     ctermfg=7    ctermbg=8       cterm=none
highlight VertSplit        ctermfg=0    ctermbg=8       cterm=none
highlight Statement        ctermfg=2    ctermbg=none    cterm=none
highlight Directory        ctermfg=4    ctermbg=none    cterm=none
highlight Comment          ctermfg=4    ctermbg=none    cterm=none
highlight Constant         ctermfg=12   ctermbg=none    cterm=none
highlight Special          ctermfg=4    ctermbg=none    cterm=none
highlight Identifier       ctermfg=6    ctermbg=none    cterm=none
highlight PreProc          ctermfg=5    ctermbg=none    cterm=none
highlight String           ctermfg=12   ctermbg=none    cterm=none
highlight Number           ctermfg=1    ctermbg=none    cterm=none
highlight Function         ctermfg=1    ctermbg=none    cterm=none
set t_Co=256 " Enable 256 colours

"" Statusline
"function! FileSize() abort
"    let l:bytes = getfsize(expand('%p'))
"    if (l:bytes >= 1024)
"        let l:kbytes = l:bytes / 1025
"    endif
"    if (exists('kbytes') && l:kbytes >= 1000)
"        let l:mbytes = l:kbytes / 1000
"    endif
"
"    if l:bytes <= 0
"        return '0'
"    endif
"
"    if (exists('mbytes'))
"        return l:mbytes . 'MB '
"    elseif (exists('kbytes'))
"        return l:kbytes . 'KB '
"    else
"        return l:bytes . 'B '
"    endif
"endfunction
"hi statusline ctermfg=black ctermbg=white
"au InsertEnter * hi statusline ctermbg=white ctermfg=green
"au InsertLeave * hi statusline ctermbg=white ctermfg=black
"set laststatus=2
"set statusline+=%F
"set statusline+=\ \ %{FileSize()}
"set statusline+=\ %r
"set statusline+=%=
"set statusline+=%m
"set statusline+=\ %y
"set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
"set statusline+=\ %-7([%{&fileformat}]%)
"set statusline+=\ [%p%%
"set statusline+=\ %l/%L]

"---Misc
"map <leader>p :w! \| !python3 %<cr>
"map <leader>sc :w! \| :!shellcheck %<cr>
"map % :w! \| !./%<cr>
"nno <silent><leader>z :!zathura --fork %:t:r.pdf<cr><cr>
"nno <silent><leader>Z :!devour zathura %:t:r.pdf<cr><cr>
"map <leader>a :set autochdir<cr>

" Compiling
"map <silent><leader>c :w! \| !compiler "<c-r>%"<cr><cr>
"map <leader>C :w! \| !compiler "<c-r>%"<cr>
"map <silent><leader>c :w! \| !compiler "<c-r>%"<cr><cr>!compiler "<c-r>%"<cr><cr>

" File templates
augroup templates
    autocmd BufNewFile *.tex 0r ~/.config/nvim/templates/skeleton.tex
    autocmd BufNewFile *.sh 0r ~/.config/nvim/templates/skeleton.sh
augroup END
