local function map(shortcut, command)
    vim.keymap.set("n", shortcut, command)
    vim.keymap.set("v", shortcut, command)
end

require("hop").setup({
    map("f", "<cmd>HopWordCurrentLine<cr>"),
    map("F", "<cmd>HopWord<cr>"),
    map("<leader>1", "<cmd>HopChar1<cr>"),
    map("<leader>2", "<cmd>HopChar2<cr>"),
    vim.cmd("hi HopNextKey guifg=#FFB86C"),
})
