function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

-- Use nmap('shortcut', 'command') for normal mode mappings
function nmap(shortcut, command)
  map('n', shortcut, command)
end

-- Use imap('shortcut', 'command') for normal mode mappings
function imap(shortcut, command)
  map('i', shortcut, command)
end

-- Use vmap('shortcut', 'command') for normal mode mappings
function vmap(shortcut, command)
  map('v', shortcut, command)
end

-- Same as nmap but don't silence
-- use this when making command mappings with '<cr>'
function nsnmap(shortcut, command)
  vim.api.nvim_set_keymap('n', shortcut, command, { noremap = true })
end

-- Basics
nmap('W', ':w<cr>')
nmap('<space>', ':noh<cr>')
nmap('cc', ':set cursorcolumn!<cr>')
vmap('<', '<gv')
vmap('>', '>gv')
nmap('n', 'nzzzv')
nmap('N', 'Nzzzv')
nmap('r', '<c-r>')

--- Line manipulation
nmap('<m-k>', 'ddkkp')
nmap('<m-j>', 'ddp')
-- Finding and replacing or deleting (works like sed)
nsnmap('S', ':%s//g<left><left>')

-- Fuzzy finding and navigating between files
nmap('o', ':browse old<cr>')
nsnmap('<c-e>', ':edit<space>')
nmap('<c-b>l', ':b <c-d>')
nmap('<c-b>p', ':bp<cr>')
nmap('<c-b>n', ':bn<cr>')

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

--- Autosurround
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

-- Compiler script
nmap('<leader>c', ':w! | !compiler "<c-r>%"<cr><cr>')
nsnmap('<leader>C', ':w! | !compiler "<c-r>%"<cr>')
nmap('<leader>cc', ':w! | !compiler "<c-r>%"<cr><cr>!compiler "<c-r>%"<cr><cr>')

-- Misc
nmap('<c-n>', ':Lexplore<cr>')
nmap('<leader>sc', ':w! | :!shellcheck %<cr>')
nmap('<leader>z', ':!zathura --fork %:t:r.pdf<cr><cr>')
nmap('<leader>Z', ':!devour zathura %:t:r.pdf<cr><cr>')
vmap('$', '$<left>')
nmap('Q', 'gq') -- replace exmode with gq
nsnmap('<c-m>', ':marks<cr>')
nmap('<leader>src', ':source %<cr>')

-- Plugin mappings
nmap('f', ':HopWord<cr>')
nsnmap('<c-p>', ':HopPattern<cr>')
