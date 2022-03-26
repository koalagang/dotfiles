-- Settings I'm not sure how to port to lua.
-- I will likely try to port them soon.
vim.cmd([[
" Fuzzy finding and navigating between files
set path+=**

" Spellcheck
set spelllang=en_gb,en_us,nb_no

" Clean up trailing spaces and single lines at the end of files
autocmd BufWritePre * %s/\s\+$//e


"---------
" AUTOCMD
" Will port to lua when I update to neovim 0.7 (adds support for autocmd)

" File templates
augroup templates
    autocmd BufNewFile *.tex 0r ~/.config/nvim/templates/skeleton.tex
    autocmd BufNewFile *.sh 0r ~/.config/nvim/templates/skeleton.sh
augroup END

" Netrw
function! OpenRight()
    :normal v
    let g:path=expand('%:p')
    echo g:path
    :q!
    execute 'belowright vnew' g:path
    :normal <c-l>
endfunction
function! OpenBelow()
    :normal v
    let g:path=expand('%:p')
    echo g:path
    :q!
    execute 'belowright new' g:path
    :normal <c-l>
endfunction

function! NetrwMappings()
    nnoremap <buffer> <c-l> <c-w>l
    nnoremap V :call OpenRight()<cr>
    nnoremap H :call OpenBelow()<cr>
endfunction

augroup netrw_mappings
    autocmd!
    autocmd filetype netrw call NetrwMappings()
augroup END

" Close netrw after opening a file (which gets opened in another window)
let g:netrw_fastbrowse = 0
autocmd FileType netrw setl bufhidden=wipe
function! CloseNetrw() abort
  for bufn in range(1, bufnr('$'))
    if bufexists(bufn) && getbufvar(bufn, '&filetype') ==# 'netrw'
      silent! execute 'bwipeout ' . bufn
      if getline(2) =~# '^" Netrw '
        silent! bwipeout
      endif
      return
    endif
  endfor
endfunction
augroup closeOnOpen
  autocmd!
  autocmd BufWinEnter * if getbufvar(winbufnr(winnr()), "&filetype") != "netrw"|call CloseNetrw()|endif
aug END

" Close vim if netrw is the only open buffer
autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw" || &buftype == 'quickfix' |q|endif

" Automatically enter insert mode when opening an empty file
autocmd BufNewFile * startinsert
autocmd VimEnter * if empty(expand("%")) | startinsert | endif
autocmd VimEnter * if getfsize(expand("%")) == 0 | startinsert | endif
]])

local o  = vim.o
local g  = vim.g
local go = vim.go
local bo = vim.bo
local wo = vim.wo

-- local to buffer
o.encoding='utf-8'
o.shiftwidth = 4
o.ignorecase = true
bo.swapfile = false
bo.tabstop = 4
bo.softtabstop = 4
bo.expandtab = true
bo.autoindent = true
bo.smartindent = true

-- local to window
wo.number = true
wo.relativenumber = true
wo.signcolumn = 'yes'
wo.cursorline = true

-- global
g.mapleader = ','
g.nobackup = true
g.netrw_banner = false
g.netrw_dirhistmax = false
g.netrw_preview = 1
g.netrw_liststyle = 3
g.netrw_browse_split = 4
g.netrw_winsize = 15
g.netrw_keepdir=0
go.smartcase = true
go.lazyredraw = true
go.wildmenu = true
go.wildignore = "*.jpg,*.png,*.gif,*.bmp,*.ico,*.pdf,*.a,*.o,*.so,*.pyc,*.git,*.tmp,*.swp"
go.wildignorecase = true
go.autowrite = false
go.termguicolors = true
