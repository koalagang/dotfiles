local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
        active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
}

vim.diagnostic.config(config)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
})

local function nmap(shortcut, command)
    vim.keymap.set("n", shortcut, command)
end

local function lsp_keymaps()
    nmap("gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")
    nmap("gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
    nmap("K", "<cmd>lua vim.lsp.buf.hover()<cr>")
    nmap("gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
    --nmap("<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
    -- nmap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>')
    nmap("gr", "<cmd>lua vim.lsp.buf.references()<cr>")
    -- nmap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    -- nmap('n', '<leader>f', '<cmd>lua vim.diagnostic.open_float()<cr>')
    nmap("[d", "<cmd>lua vim.diagnostic.goto_prev({ border = 'rounded' })<cr>")
    nmap("gl", "<cmd>lua vim.diagnostic.open_float({ border = 'rounded' })<cr>")
    nmap("]d", "<cmd>lua vim.diagnostic.goto_next({ border = 'rounded' })<cr>")
    nmap("<leader>q", "<cmd>lua vim.diagnostic.setloclist()<cr>")
    vim.cmd([[ command! Format execute "lua vim.lsp.buf.formatting()" ]])
end

local on_attach = function(_)
    if _.name == "sumneko_lua" then
        _.resolved_capabilities.document_formatting = false
    elseif _.name == "rust_analyzer" then
        _.resolved_capabilities.document_formatting = false
    end
    lsp_keymaps()
end

-- nvim-cmp supports additional completion capabilities
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local servers = { "kotlin_language_server", "texlab", "sumneko_lua", "prosemd_lsp", "rnix", "taplo", "rust_analyzer" }

-- Ensure the servers above are installed
require("mason-lspconfig").setup({
    ensure_installed = servers,
})

for _, lsp in ipairs(servers) do
    require("lspconfig")[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require("lspconfig").sumneko_lua.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT)
                version = "LuaJIT",
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = { enable = false },
        },
    },
})
