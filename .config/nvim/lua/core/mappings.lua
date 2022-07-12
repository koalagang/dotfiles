-- TODO: swap out `vim.api.nvim_set_keymap` with `vim.keymap.set`

-- [[ Functions ]]
-- These make the syntax for creating mappings with lua far easier
local function map(mode, shortcut, command)
	vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

-- Use nmap('shortcut', 'command') for normal mode mappings
local function nmap(shortcut, command)
	map("n", shortcut, command)
end

-- Use imap('shortcut', 'command') for normal mode mappings
local function imap(shortcut, command)
	map("i", shortcut, command)
end

-- Use vmap('shortcut', 'command') for normal mode mappings
local function vmap(shortcut, command)
	map("v", shortcut, command)
end

-- [[ Basics ]]
-- Basic bindings
nmap("<c-s>", "<cmd>w<cr>")
nmap("<space>", "<cmd>noh<cr>")
nmap("cc", "<cmd>set cursorcolumn!<cr>")
vmap("<", "<gv")
vmap(">", ">gv")
nmap("n", "nzzzv")
nmap("N", "Nzzzv")
-- Swap redo and replace around
nmap("r", "<c-r>")
nmap("<c-r>", "r")
-- Move lines up and down with alt-j and alt-k
nmap("<m-k>", "<cmd>m .-2<cr>==")
nmap("<m-j>", "<cmd>m .+1<cr>==")
vmap("<m-k>", ":m '<-2<cr>gv=gv")
vmap("<m-j>", ":m '>+1<cr>gv=gv")
-- Find and replace (similar to sed)
nmap("S", ":%s//g<left><left>")
vmap("S", ":s//g<left><left>")

-- [[ Navigate multiple files ]]
-- Splits
nmap("<c-j>", "<c-w><c-j>")
nmap("<c-k>", "<c-w><c-k>")
nmap("<c-l>", "<c-w><c-l>")
nmap("<c-h>", "<c-w><c-h>")
nmap("<c-p>", "<cmd>vertical resize +2<cr>")
nmap("<c-m>", "<cmd>vertical resize -2<cr>")
nmap("<m-p>", "<cmd>resize +2<cr>")
nmap("<m-m>", "<cmd>resize -2<cr>")
nmap("<leader>sv", "<cmd>vs<cr>")
nmap("<leader>sh", "<cmd>sp<cr>")
nmap("<leader>sw", "<c-w><c-x>")
-- Tabs
nmap("<Tab>", "gt")
nmap("<S-Tab>", "gT")
nmap("<c-t>", "<cmd>tabnew<cr>")
nmap("tf", "tabfind<space>")
-- Move between files
nmap("o", "<cmd>browse old<cr>")
nmap("<c-e>", ":edit<space>")
nmap("<c-b>l", "<cmd>b <c-d>")
nmap("<c-b>p", "<cmd>bp<cr>")
nmap("<c-b>n", "<cmd>bn<cr>")

-- [[ Autosurround ]]
imap('"', '""<left>')
imap("'", "''<left>")
imap("(", "()<left>")
imap("[", "[]<left>")
imap("{", "{}<left>")
imap("<", "<><left>")
imap("`", "``<left>")
-- Prevent autosurround with alt
imap('<m-">', '"')
imap("<m-'>", "'")
imap("<m-(>", "(")
imap("<m-[>", "[")
imap("<m-{>", "{")
imap("<m-<>", "<")
imap("<m-`>", "`")
-- This section is here so that holding alt does not prevent your from entering
-- the desired character
imap("<m-)>", ")")
imap("<m-]>", "]")
imap("<m-}>", "}")
imap("<m->>", ">")

-- [[ Misc ]]
-- Navigate using HJKL in insert mode (while holding down ctrl)
imap("<c-h>", "<left>")
imap("<c-j>", "<down>")
imap("<c-k>", "<up>")
imap("<c-l>", "<right>")

-- [[ Registers ]]
-- Yanking to system clipboard
-- NOTE: as ctrl-v has been remapped, use ctrl-q instead to enter visual block mode
-- EXTERNAL DEPENDENCY: xclip or xsel (X11), wl-clipboard (wayland)
vmap("<c-c>", '"+y')
vmap("<c-x>", '"+d')
nmap("<c-c>", '"+yy')
nmap("<c-v>", '"+p')
nmap("<c-x>", '"+dd')
vmap("y", '"ay')
vmap("d", '"ad')

-- [[ Other shortcuts ]]
nmap("<c-n>", "<cmd>Lexplore<cr>")
vmap("$", "$<left>")
nmap("M", "<cmd>marks<cr>")
nmap("<leader>src", "<cmd>source %<cr>")
nmap("ss", "<cmd>set spell!<cr>") -- Spellcheck

-- Scripts and other external software
nmap("<leader>c", '<cmd>w! | !compiler "<c-r>%"<cr><cr>')
nmap("<leader>C", ':w! | !compiler "<c-r>%"<cr>')
nmap("<leader>cc", '<cmd>w! | !compiler "<c-r>%"<cr><cr>!compiler "<c-r>%"<cr><cr>')
nmap("<leader>sc", "<cmd>w! | <cmd>!shellcheck %<cr>")
nmap("<leader>z", "<cmd>!zathura --fork %<cmd>t<cmd>r.pdf<cr><cr>")
nmap("<leader>Z", "<cmd>!devour zathura %<cmd>t<cmd>r.pdf<cr><cr>")
