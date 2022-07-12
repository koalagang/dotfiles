local function map(shortcut, command)
	vim.api.nvim_set_keymap("n", shortcut, command, { noremap = true, silent = true })
end

require("hop").setup({
	map("f", "<cmd>HopWordCurrentLine<cr>"),
	map("F", "<cmd>HopWord<cr>"),
	--map("<c-p>", "<cmd>HopPattern<cr>"),
	map("<leader>1", "<cmd>HopChar1<cr>"),
	map("<leader>2", "<cmd>HopChar2<cr>"),
	vim.cmd("hi HopNextKey guifg=#FFB86C"),
})
