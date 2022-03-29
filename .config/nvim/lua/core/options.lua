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
bo.spelllang = 'en_gb,en_us,nb_no'

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
