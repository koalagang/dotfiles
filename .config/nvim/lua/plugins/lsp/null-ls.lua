local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/code_actions
local code_actions = null_ls.builtins.code_actions

-- TODO: setup null-ls with other languages I use

null_ls.setup({
	debug = false,
	sources = {
		-- lua
		formatting.stylua,

		-- python
		formatting.black,
		diagnostics.flake8,

		-- shell
		formatting.shfmt.with({ extra_args = { "-i 4", "-sr", "-s", "-ln posix" } }),
		diagnostics.shellcheck,

		-- rust
		formatting.rustfmt,

		-- other
		code_actions.gitsigns,
	},
})

-- format on save
vim.cmd([[
augroup LspFormatting
    autocmd! * <buffer>
    autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
augroup END
]])

--[[ TODO:
https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/lua/null-ls/builtins/completion/luasnip.lua
https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/lua/null-ls/builtins/completion/spell.lua
https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/lua/null-ls/builtins/diagnostics/rstcheck.lua
https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/lua/null-ls/builtins/code_actions/gitsigns.lua
https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/lua/null-ls/builtins/hover/dictionary.lua
Also, set up rust formatting?
]]
