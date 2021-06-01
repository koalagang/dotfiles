"  \##|   |
"##\\ |   |
"   \\|   \'---'/   Dante (@koalagang)
"    \   _'.'O'.'   https://github.com/koalagang
"     | :___   \    (╯°□°）╯︵ sɔɐɯ ǝ
"     |  _| :  |
"     | :__,___/    "Plugins are great but can often be overkill. I aim to use as few plugins as possible without losing out on valuable features."
"     |   |
"     |   |         "Inspiration: https://www.youtube.com/watch?v=XA2WjJbmmoM"
"     |   |
"     |   |
"---Basics
let mapleader = ','
set number relativenumber
set tabstop=4 softtabstop=0 shiftwidth=4 expandtab autoindent smartindent
set smartcase ignorecase
set nobackup noswapfile lazyredraw
set cursorline
hi CursorLine   cterm=NONE ctermbg=black
hi CursorColumn cterm=NONE ctermbg=black
nno <silent> cc :set cursorcolumn!<cr>
nno zz :w<cr>
nno <silent> <space> :noh<cr>
vn <space> v
vn < <gv
vn > >gv
nno n nzzzv
nno N Nzzzv
nno r <c-r>
" Vim wiki syntax is used instead of markdown by default
no md :set ft=markdown<cr>

" Line navigation and manipulation
no <c-a> ggv^G$
nno <m-k> dd2kp
nno <m-j> ddp
nno J L
nno K H
nno L $
nno H ^
nno <return> M
vn J L
vn K H
vn <return> M

" Finding and replacing or deleting:
nno S :%s//g<left><left>
"-  e.g. :s%s/x/y/g finds every x and replaces them all with a y.
"-  e.g. :s%s/x/g finds every x and deletes them all.

" Fuzzy finding and navigating between files
nno o :browse old<cr>
nno fo :filter '.*' oldfiles<c-left><left><left>
nno e :edit<space>
nno bb :b <c-d>
nno bp :bp<cr>
nno bn :bn<cr>
nno ff :find<space>
nno <leader>A :argadd <c-r>=fnameescape(expand('%:p:h'))<cr>/*<c-d>
nno fdo :edit ~/Documents/**/*
nno f.c :edit ~/.config/**/*
nno fde :edit ~/Desktop/**/*
set path+=**
set wildmenu
set wildignore+=*.jpg,*.png,*.gif,*.bmp,*.ico,*.pdf,*.a,*.o,*.so,*.pyc,*.git,*.tmp,*.swp " Ignore unnecessary file extensions in wildmenu
set wildignorecase
" next completion on /
cnoremap <expr> / wildmenumode() ? "\<C-E>" : "/"
" if we type ':***' then it will change to ':**/*'
cnoremap <expr> * getcmdline () =~ '.*\*\*$' ? '/*' : '*'
" Find under root directory
function! FindRootDirectory()
    if !filereadable('Makefile') && !filereadable('makefile')
        let root = systemlist('git -rev-parse --show-toplevel')[0]
        if v:shell_error
            return ''
        endif
        return root
    endif
    return expand('%:p:h')
endfunction
nno fr :edit <c-r>=FindRootDirectory()<cr>/**/*
let g:vimwiki_list = [{'path': '~/Documents/vimwiki', 'syntax': 'default', 'ext': '.wiki'}]
map <leader>v <Plug>VimwikiIndex

" Mouse
set mouse=nirv " If your terminal allows you to click links, you must enter command mode or shift-click to press them
set mousehide
set mousefocus
behave mswin
map <MiddleMouse>  "+p
map <RightMouse> "+y

" Splits
nno <c-j> <c-w><c-j>
nno <c-k> <c-w><c-k>
nno <c-l> <c-w><c-l>
nno <c-h> <c-w><c-h>
nno <m-i> :vertical resize +2<cr>
nno <m-o> :vertical resize -2<cr>
nno <m-I> :resize +2<cr>
nno <m-O> :resize -2<cr>
nno <leader>sv :vs<cr>
nno <leader>sh :sp<cr>
nno <leader>sw <c-w><c-x>

" Netrw
let g:netrw_banner=0            " - disable annoying banner
let g:netrw_liststyle=3         " - tree view
let g:netrw_browse_split=4
let g:netrw_winsize=15
let g:netrw_preview=1
nno <c-n> :Lexplore<cr>

" Allows you to use HJKL to navigate in insert mode if you hold down ctrl
ino <c-h> <left>
ino <c-j> <down>
ino <c-k> <up>
ino <c-l> <right>

" Tabs
nno <Tab> gt
nno <S-Tab> gT
nno <silent> <s-t> :tabnew<cr>
nno tf :tabfind<space>

" Accidentally using capitals to exit is not a problem
" (although you should use ZZ and ZQ to exit vim)
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev WQ wq
cnoreabbrev wQ wq
cnoreabbrev Wq wq
cnoreabbrev Qall qall

" Autosurround
ino " ""<left>
ino ' ''<left>
ino ( ()<left>
ino [ []<left>
ino { {}<left>
ino < <><left>
ino ` ``<left>
" Prevent autosurround with left alt
ino <m-"> "
ino <m-'> '
ino <m-(> (
ino <m-[> [
ino <m-{> {
ino <m-<> <
ino <m-`> `
" This section is here so that holding alt does not prevent your from entering
" the desired character
ino <m-)> )
ino <m-]> ]
ino <m-}> }
ino <m->> >

"---Yanking and pasting
" Register A
vn y "ay
vn d "ad
no p "ap
nno yy "ayy
nno dd "add
" Register B
vn Y "by
vn D "bd
no P "bp
nno YY "byy
nno DD "bdd
" System register
" NOTE: to interact with the system register, you must have 'xclip' installed
" NOTE: use ctrl-q to enter visual block mode (instead of ctrl-v)
vn <c-c> "+y
vn <c-x> "+d
no <c-v> "+p
nno <c-c> "+yy
nno <c-x> "+dd
ino <c-v> <esc> "+p <up> A

" Remove a line or word without copying to register
" NOTE: use capital x (X) to remove single characters
nno xx Vx
nno cix ciw<backspace><esc>

"---Plugins
call plug#begin()
Plug 'Yggdroot/indentLine'
Plug 'ap/vim-css-color'
Plug 'vimwiki/vimwiki'
" Plugin which adds support for GDscript and running the Godot Engine directly
" from Vim
Plug 'habamax/vim-godot'
call plug#end()

" Plug commands
":PlugInstall   - installs plugins
":PlugUpdate    - updates plugins
":PlugDiff      - shows changes (after running :PlugUpdate)
":PlugClean     - remove plugins (first remove or comment them out and then restart vim)
"To rollback to an older version of a plugin, run :PlugDiff and then press 'X' on each paragraph.

" Godot
nno <buffer> grl :GodotRunLast<CR>
nno <buffer> grr :GodotRun<CR>
nno <buffer> grc :GodotRunCurrent<CR>
nno <buffer> grf :GodotRunFZF<CR>

"Spellcheck
set spelllang=en_gb,nb_no
nno ss :set spell!<cr>
nno sgb :setlocal spell! spelllang=en_gb!<cr>
no sus :set spell! spelllang=en_us!<cr>
nno sno :set spell! spelllang=nb_no!<cr><cr>
nno <leader>z z=
nno } ]s
nno { [s

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

"---Markdown
" Bold
no <leader>i <esc>Bi*<esc>Ea*<esc>
" Italics
no <leader>b <esc>Bi**<esc>Ea**<esc>
" Bold Italics
no <leader>mbi <esc>Bi***<esc>Ea***<esc>
" Headings
nno <leader>h1 <esc>I# <esc>
nno <leader>h2 <esc>I## <esc>
nno <leader>h3 <esc>I### <esc>
nno <leader>h4 <esc>I#### <esc>
nno <leader>h5 <esc>I##### <esc>
nno <leader>h6 <esc>I###### <esc>

"---Misc
map <c-s> :!shellcheck %<cr>
map <leader>c :w! \| !compiler "<c-r>%"<cr><cr>
map <leader>p :w! \| !python3 %<cr>
map <leader>sc :w! \| :!shellcheck %<cr>
map ./ :w! \| !./%<cr>
nno <leader>Z :!zathura --fork %:t:r.pdf<cr><cr>
map <leader>a :set autochdir<cr>

" Templates
nno ,html :-1read ~/.config/nvim/.skeleton.html<cr>3jwf>a
nno ,md :-1read ~/.config/nvim/.skeleton.md<cr>GkA<space>

" Commenting stuff out (in various languages) - single line commenting
nno <leader># <esc>I#<esc>
nno <leader>" <esc>I"<esc>
nno <leader>/ <esc>I//<esc>
nno <leader>- <esc>I--<esc>
nno <leader>% <esc>I%<esc>
" Uncomment
nno ; <esc>I<del><esc>
