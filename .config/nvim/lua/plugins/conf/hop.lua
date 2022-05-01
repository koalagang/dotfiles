local function map(shortcut, command)
	vim.api.nvim_set_keymap("n", shortcut, command, { noremap = true, silent = true })
end

require("hop").setup({
	map("f", "<cmd>HopWord<cr>"),
	map("F", "<cmd>HopWordCurrentLine<cr>"),
	--map("<c-p>", "<cmd>HopPattern<cr>"),
	map("<leader>1", "<cmd>HopChar1<cr>"),
	vim.cmd("hi HopNextKey guifg=#FFB86C"),
})
