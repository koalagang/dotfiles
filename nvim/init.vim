"  \##|   |
"##\\ |   |
"   \\|   \'---'/   Dante (@koalagang)
"    \   _'.'O'.'   https://github.com/koalagang
"     | :___   \    (╯°□°）╯︵ sɔɐɯ ǝ
"     |  _| :  |
"     | :__,___/    "An init.vim which aims to use as few plugins as possible, without losing out on valuable features."
"     |   |
"     |   |         "Inspiration: https://www.youtube.com/watch?v=XA2WjJbmmoM"


"---Basics
set number relativenumber
set tabstop=4 softtabstop=0 shiftwidth=4 expandtab autoindent smartindent
set smartcase ignorecase
set nobackup noswapfile
set cursorline
hi CursorLine gui=underline cterm=underline
let mapleader = ','
nnoremap r <C-r>


"---Navigation
map <C-o> :bro ol <CR> " Navigate recently used files
set path+=** " Search current directory recursively
set wildmenu
set wildignore+=*.jpg,*.png,*.gif,*.bmp,*.ico,*.pdf,*.a,*.o,*.so,*.pyc,*.git,*.tmp,*.swp " Ignore unnecessary file extensions in wildmenu
nnoremap <C-t> :tabe <CR>
nnoremap <C-f> :find<Space>
nnoremap <Space> :noh <CR>
noremap <C-a> gg v G $ "Select everything

" Finding and replacing or deleting:
nnoremap S :%s//g<Left><Left>
"-  e.g. :s%s/x/y/g finds every x and replaces them all with a y.
"-  e.g. :s%s/x/g finds every x and deletes them all.
"
" Mouse
set mouse=nir " If your terminal allows you to click hyperlinks, enter command mode (:) to press them
set mousehide
set mousefocus
behave mswin
map <MiddleMouse>  "+p
map <RightMouse> "+y

" Splits
map <C-J> <C-W><C-J>
map <C-K> <C-W><C-K>
map <C-L> <C-W><C-L>
map <C-H> <C-W><C-H>
map <leader>v :vs<CR>
map <leader>h :split<CR>

" Netrw
let g:netrw_banner=0            " - disable annoying banner
let g:netrw_browse_split=2      " - use vertical split (2 = vertical, 1 = horizontal = default)
let g:netrw_liststyle=3         " - tree view
nnoremap <C-n> :edit . <Return>
" Allows you to use HJKL to navigate in insert mode if you hold control
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>


" Accidentally using capitals to exit is not a problem
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev WQ wq
cnoreabbrev wQ wq
cnoreabbrev Wq wq


" Autosurround
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap < <><left>


"---Yanking and pasting
"
" Register A
vnoremap y "ay
vnoremap d "ad
noremap p "ap
nnoremap yy "ayy
nnoremap dd "add

" Register B
vnoremap Y "by
vnoremap D "bd
noremap P "bp
nnoremap YY "byy
nnoremap DD "bdd

" System register
vnoremap <C-c> "+y
vnoremap <C-x> "+d
noremap <C-v> "+p
nnoremap <C-c> "+yy
nnoremap <C-x> "+dd
inoremap <C-v> <Esc> "+p a
nnoremap <F1> :!bash clearclipboard<CR><CR> " Clear the system register (clipboard)


"---Plugins
call plug#begin()

Plug 'Yggdroot/indentLine'
Plug 'ap/vim-css-color'
Plug 'vimwiki/vimwiki'

call plug#end()

" Plug commands
":PlugInstall   - installs plugins
":PlugUpdate    - updates plugins
":PlugDiff      - shows changes
":PlugClean     - remove plugins (first remove or comment them out and then restart vim)
"To view rollback to an older version of a plugin, run :PlugDiff and then press 'X' on each paragraph.


"Spellcheck
map <F5> :set nospell                           " - Turn off spellcheck
map <F6> :setlocal spell! spelllang=en_gb<CR>   " - Use British spellcheck
map <F7> :set spell! spelllang=en_us<CR>        " - Use American spellcheck


"---Tidying
"
"Convert text to UTF-8
setglobal termencoding=utf-8 fileencodings=
scriptencoding utf-8
set encoding=utf-8
autocmd BufNewFile,BufRead  *    try
autocmd BufNewFile,BufRead  *    set encoding=utf-8
autocmd BufNewFile,BufRead  *    endtry

"Convert fileformat to unix
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
set t_Co=256 "enable 256 colours
let g:indentLine_color_term = 14 " Changes the colour of indentlines (created by the indentline plugin)

" Statusline
function! FileSize() abort
    let l:bytes = getfsize(expand('%p'))
    if (l:bytes >= 1024)
        let l:kbytes = l:bytes / 1025
    endif
    if (exists('kbytes') && l:kbytes >= 1000)
        let l:mbytes = l:kbytes / 1000
    endif

    if l:bytes <= 0
        return '0'
    endif

    if (exists('mbytes'))
        return l:mbytes . 'MB '
    elseif (exists('kbytes'))
        return l:kbytes . 'KB '
    else
        return l:bytes . 'B '
    endif
endfunction
hi statusline ctermfg=black ctermbg=white
au InsertEnter * hi statusline ctermbg=white ctermfg=green
au InsertLeave * hi statusline ctermbg=white ctermfg=black
set laststatus=2
set statusline+=%F
set statusline+=\ \ %{FileSize()}
set statusline+=\ %r
set statusline+=%=
set statusline+=%m
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ %-7([%{&fileformat}]%)
set statusline+=\ [%p%%
set statusline+=\ %l/%L]


" Misc
nnoremap ,html :-1read ~/.config/nvim/.skeleton.html<CR>3jwf>a
map <leader>s :!shellcheck %<CR>
map <leader>c :w! \| !bash compiler "<c-r>%"<CR><CR>
map <leader>p :w !python3 %<CR>
map <C-z> :!zathura --fork %:t:r.pdf<CR><CR>
