vim.g.vimwiki_global_ext = false
vim.g.vimwiki_list = { path = "~/Documents/vimwiki", syntax = "markdown", ext = ".md" }
vim.g.vimwiki_ext2syntax = { [".md"] = "markdown", [".markdown"] = "markdown", [".mdown"] = "markdown" }
vim.g.vimwiki_conceallevel = 2

local function map(shortcut, command)
    vim.api.nvim_set_keymap("n", shortcut, command, { noremap = true, silent = true })
end

-- Find files in vimwiki
map("<leader>fw", "<cmd>Telescope find_files cwd=~/Documents/vimwiki<cr>")
-- Live grep vimwiki
map("<leader>gw", "<cmd>Telescope live_grep cwd=~/Documents/vimwiki<cr>")
