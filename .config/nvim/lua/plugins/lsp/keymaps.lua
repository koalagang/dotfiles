-- required by lsp.lua and null-ls.lua

local function nmap(shortcut, command)
    vim.keymap.set("n", shortcut, "<cmd>lua vim." .. command .. "<cr>")
end

function lsp_keymaps()
    nmap("gD", "lsp.buf.declaration()")
    nmap("gd", "lsp.buf.definition()")
    nmap("T", "lsp.buf.hover()")
    nmap("gi", "lsp.buf.implementation()")
    -- nmap("<C-k>", "lsp.buf.signature_help()")
    -- nmap('n', '<leader>rn', 'lsp.buf.rename()')
    nmap("gr", "lsp.buf.references()")
    nmap("gca", "lsp.buf.code_action()")
    -- nmap('n', '<leader>f', 'diagnostic.open_float()')
    nmap("[d", "diagnostic.goto_prev({ border = 'rounded' })")
    nmap("gO", "diagnostic.open_float({ border = 'rounded' })")
    nmap("]d", "diagnostic.goto_next({ border = 'rounded' })")
    nmap("<leader>q", "diagnostic.setloclist()")
    nmap("gF", "lsp.buf.format()")
end
