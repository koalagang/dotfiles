"  \##|   |
"##\\ |   |
"   \\|   \'---'/   Dante (@koalagang)
"    \   _'.'O'.'   https://github.com/koalagang
"     | :___   \    (╯°□°）╯︵ sɔɐɯ ǝ
"     |  _| :  |
"     | :__,___/    "A vim config which aims to use as few plugins as possible without losing out on valuable features."
"     |   |
"     |   |         "Inspiration: https://www.youtube.com/watch?v=XA2WjJbmmoM"
"     |   |
"     |   |
"---Basics
set number relativenumber
set tabstop=4 softtabstop=0 shiftwidth=4 expandtab autoindent smartindent
set smartcase ignorecase
set nobackup noswapfile lazyredraw
set cursorline
hi CursorLine gui=underline cterm=underline
let mapleader = ','

"---Navigation
map <c-o> :bro ol <cr> " Navigate recently used files
set path+=** " Search current directory recursively
set wildmenu
set wildignore+=*.jpg,*.png,*.gif,*.bmp,*.ico,*.pdf,*.a,*.o,*.so,*.pyc,*.git,*.tmp,*.swp " Ignore unnecessary file extensions in wildmenu
nnoremap <c-f> :find<space>
nnoremap <space> :noh<cr>
noremap <c-a> gg v G $
nnoremap <c-up> dd 2k p
nnoremap <c-down> dd p
nnoremap J L
nnoremap K H
nnoremap <return> M
" For when I am using the Norwegian keyboard layout
nnoremap Ø :
nnoremap - /

" Finding and replacing or deleting:
nnoremap S :%s//g<left><left>
"-  e.g. :s%s/x/y/g finds every x and replaces them all with a y.
"-  e.g. :s%s/x/g finds every x and deletes them all.

" Mouse
set mouse=nir " If your terminal allows you to click hyperlinks, you must enter command mode (:) to press them
set mousehide
set mousefocus
behave mswin
map <MiddleMouse>  "+p
map <RightMouse> "+y

" Splits
nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-l> <c-w><c-l>
nnoremap <c-h> <c-w><c-h>
nnoremap <m-l> :vertical resize +2<cr>
nnoremap <m-h> :vertical resize -2<cr>
nnoremap <m-j> :resize +2<cr>
nnoremap <m-k> :resize -2<cr>
nnoremap <leader>v :vs<cr>
nnoremap <leader>s :split<cr>

" Netrw
let g:netrw_banner=0            " - disable annoying banner
let g:netrw_liststyle=3         " - tree view
nnoremap <c-n> :edit .<cr>

" Allows you to use HJKL to navigate in insert mode if you hold alt
inoremap <m-h> <left>
inoremap <m-j> <down>
inoremap <m-k> <up>
inoremap <m-l> <right>

" Tabs
nnoremap <m-t> :tabe<cr>
nnoremap <m-n> :tabn<cr>
nnoremap <m-p> :tabp<cr>
nnoremap <m-q> :tabclose<cr>
nnoremap tf :tabfind<space>

" Accidentally using capitals to exit is not a problem
" (although you should be using ZZ and ZQ to exit vim)
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
" Prevent autosurround with left alt
inoremap <m-"> "
inoremap <m-'> '
inoremap <m-(> (
inoremap <m-[> [
inoremap <m-{> {
inoremap <m-<> <


"---Yanking and pasting
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
vnoremap <c-c> "+y
vnoremap <c-x> "+d
noremap <c-v> "+p
nnoremap <c-c> "+yy
nnoremap <c-x> "+dd
inoremap <c-v> <esc> "+p <up> A

noremap <c-p> P

"---Plugins
call plug#begin()
Plug 'Yggdroot/indentLine'
Plug 'ap/vim-css-color'
Plug 'vimwiki/vimwiki'
call plug#end()

" Plug commands
":PlugInstall   - installs plugins
":PlugUpdate    - updates plugins
":PlugDiff      - shows changes (after running :PlugUpdate)
":PlugClean     - remove plugins (first remove or comment them out and then restart vim)
"To rollback to an older version of a plugin, run :PlugDiff and then press 'X' on each paragraph.


"Spellcheck
set spelllang=en_gb,nb_no
nnoremap ss :set spell<cr>
nnoremap sns :set nospell<cr>
nnoremap sgb :setlocal spell! spelllang=en_gb<cr>
noremap sus :set spell! spelllang=en_us<cr>
nnoremap sno :set spell! spelllang=nb_no<cr><cr>
nnoremap <down>s ]s
nnoremap <right>s ]s
nnoremap <up>s [s
nnoremap <left>s [s
nnoremap <leader>r z=

"---Tidying
"Convert text to UTF-8 and fileformat to Unix
setglobal termencoding=utf-8 fileencodings=
scriptencoding utf-8
set encoding=utf-8
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


"---Misc
" Some useful bindings
nnoremap ,html :-1read ~/.config/nvim/.skeleton.html<cr>3jwf>a
map <c-s> :!shellcheck %<cr>
map <leader>c :w! \| !bash compiler "<c-r>%"<cr><cr>
map <leader>p :w !python3 %<cr>
nnoremap <leader>z :!zathura --fork %:t:r.pdf<cr><cr>
map <leader>a :set autochdir<cr>
nnoremap <leader>b :3 <cr>"+p :wq<cr>
nnoremap r <c-r>
nnoremap <c-h> <c-left>
nnoremap <c-l> <c-right>
