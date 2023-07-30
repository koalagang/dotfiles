local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    return
end

local status_okay, null_ls = pcall(require, "null-ls")
if not status_okay then
    return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local hover = null_ls.builtins.hover
--local completion = null_ls.builtins.completion

-- TODO: setup null-ls with other languages I use

null_ls.setup({
    debug = false,
    sources = {
        -- lua
        formatting.stylua.with({ extra_args = { "--indent-type", "Spaces" } }),
        --completion.luasnip, -- consider

        -- shell
        formatting.shfmt.with({ extra_args = { "-i 4", "-sr", "-s", "-ln posix" } }),
        --formatting.shellharden, -- considering replacing shfmt with shellharden
        diagnostics.shellcheck,
        code_actions.shellcheck,
        hover.printenv,

        -- misc
        code_actions.gitsigns,
        formatting.rustfmt,
        --completion.spell, -- consider
        --diagnostics.todo_comments, -- only seems to work for lua; might use folke/todo-comments.nvim instead
        --hover.dictionary, -- consider
        -- to consider: alejandra, mdformat, nixfmt, nixpkgs_fmt
    },
})

-- format on save
local LspFormatting = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre <buffer>", {
    pattern = "*",
    command = "lua vim.lsp.buf.format()",
    group = LspFormatting,
})

require("plugins.lsp.keymaps")
lsp_keymaps()
