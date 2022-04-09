vim.g.indent_blankline_show_first_indent_level = false
vim.g.indent_blankline_filetype_exclude = { "lspinfo", "packer", "checkhealth", "help", "markdown" }
vim.opt.list = true

require("indent_blankline").setup({
	space_char_blankline = " ",
	show_current_context = true,
	show_current_context_start = true,
})
