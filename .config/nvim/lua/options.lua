vim.cmd([[
" Fuzzy finding and navigating between files
set path+=**

" Netrw
let g:netrw_banner=0            " disable annoying banner
let g:netrw_liststyle=3         " tree view let g:netrw_browse_split=4
let g:netrw_winsize=15
let g:netrw_preview=1
let g:netrw_dirhistmax=0        " Remove netrw history

" Spellcheck
set spelllang=en_gb,en_us,nb_no
]])

local o  = vim.o
local g  = vim.g
local go = vim.go
local bo = vim.bo
local wo = vim.wo


o.encoding="utf-8"
o.shiftwidth = 4
o.ignorecase = true

g.mapleader = ","
g.nobackup = true

go.smartcase = true
go.lazyredraw = true
go.shortmess = "sI"
go.wildmenu = true
-- Ignore unnecessary file extensions in wildmenu
go.wildignore = "*.jpg,*.png,*.gif,*.bmp,*.ico,*.pdf,*.a,*.o,*.so,*.pyc,*.git,*.tmp,*.swp"
go.wildignorecase = true

bo.swapfile = false
bo.tabstop = 4
bo.softtabstop = 4
bo.expandtab = true
bo.autoindent = true
bo.smartindent = true

wo.number = true
wo.relativenumber = true
wo.cursorline = true
