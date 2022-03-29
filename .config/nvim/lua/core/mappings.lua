-- [[Functions]]
-- These make the syntax for creating mappings with lua far easier
local function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

-- Use nmap('shortcut', 'command') for normal mode mappings
local function nmap(shortcut, command)
  map('n', shortcut, command)
end

-- Use imap('shortcut', 'command') for normal mode mappings
local function imap(shortcut, command)
  map('i', shortcut, command)
end

-- Use vmap('shortcut', 'command') for normal mode mappings
local function vmap(shortcut, command)
  map('v', shortcut, command)
end

-- Same as nmap but don't silence
-- use this when making command mappings with '<cr>'
local function nsnmap(shortcut, command)
  vim.api.nvim_set_keymap('n', shortcut, command, { noremap = true })
end



-- [[Basics]]

-- Basic bindings
nmap('<c-s>', ':w<cr>')
nmap('<space>', ':noh<cr>')
nmap('cc', ':set cursorcolumn!<cr>')
vmap('<', '<gv')
vmap('>', '>gv')
nmap('n', 'nzzzv')
nmap('N', 'Nzzzv')

-- Swap redo and replace around
nmap('r', '<c-r>')
nmap('<c-r>', 'r')

-- Move lines up and down with alt-j and alt-k
nmap('<m-k>', 'ddkkp')
nmap('<m-j>', 'ddp')

-- Find and replace (similar to sed)
nsnmap('S', ':%s//g<left><left>')



-- [[Navigate multiple files]]

-- Splits
nmap('<c-j>', '<c-w><c-j>')
nmap('<c-k>', '<c-w><c-k>')
nmap('<c-l>', '<c-w><c-l>')
nmap('<c-h>', '<c-w><c-h>')
nmap('<c-p>', ':vertical resize +2<cr>')
nmap('<c-m>', ':vertical resize -2<cr>')
nmap('<m-p>', ':resize +2<cr>')
nmap('<m-m>', ':resize -2<cr>')
nmap('<leader>sv', ':vs<cr>')
nmap('<leader>sh', ':sp<cr>')
nmap('<leader>sw', '<c-w><c-x>')

-- Tabs
nmap('<Tab>', 'gt')
nmap('<S-Tab>', 'gT')
nmap('<c-t>', ':tabnew<cr>')
nmap('tf', 'tabfind<space>')

-- Move between files
nmap('o', ':browse old<cr>')
nsnmap('<c-e>', ':edit<space>')
nmap('<c-b>l', ':b <c-d>')
nmap('<c-b>p', ':bp<cr>')
nmap('<c-b>n', ':bn<cr>')



-- [[Autosurround]]
imap('"', '""<left>')
imap("'", "''<left>")
imap('(', '()<left>')
imap('[', '[]<left>')
imap('{', '{}<left>')
imap('<', '<><left>')
imap('`', '``<left>')

-- Prevent autosurround with alt
imap('<m-">', '"')
imap("<m-'>", "'")
imap('<m-(>', '(')
imap('<m-[>', '[')
imap('<m-{>', '{')
imap('<m-<>', '<')
imap('<m-`>', '`')

-- This section is here so that holding alt does not prevent your from entering
-- the desired character
imap('<m-)>', ')')
imap('<m-]>', ']')
imap('<m-}>', '}')
imap('<m->>', '>')



-- [[External software]]

-- Plugin mappings
nmap('f', ':HopWord<cr>')
nsnmap('<leader>p', ':HopPattern<cr>')
nmap("<leader>ff", ":Telescope find_files<cr>")
nmap("<leader>lg", ":Telescope live_grep<cr>")

-- Scripts and other external software
nmap('<leader>c', ':w! | !compiler "<c-r>%"<cr><cr>')
nsnmap('<leader>C', ':w! | !compiler "<c-r>%"<cr>')
nmap('<leader>cc', ':w! | !compiler "<c-r>%"<cr><cr>!compiler "<c-r>%"<cr><cr>')
nmap('<leader>sc', ':w! | :!shellcheck %<cr>')
nmap('<leader>z', ':!zathura --fork %:t:r.pdf<cr><cr>')
nmap('<leader>Z', ':!devour zathura %:t:r.pdf<cr><cr>')



-- [[Misc]]
-- Navigate using HJKL in insert mode (while holding down ctrl)
imap('<c-h>', '<left>')
imap('<c-j>', '<down>')
imap('<c-k>', '<up>')
imap('<c-l>', '<right>')

-- Yanking to system clipboard
-- NOTE: as ctrl-v has been remapped, use ctrl-q to enter visual block mode
vmap('<c-c>', '"+y')
vmap('<c-x>', '"+d')
nmap('<c-c>', '"+yy')
nmap('<c-v>', '"+p')
nmap('<c-x>', '"+dd')

-- Spellcheck
nmap('ss', ':set spell!<cr>')

-- Other shortcuts
nmap('<c-n>', ':Lexplore<cr>')
vmap('$', '$<left>')
nmap('Q', 'gq') -- replace exmode with gq
nsnmap('M', ':marks<cr>')
nmap('<leader>src', ':source %<cr>')
