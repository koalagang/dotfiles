local cmd = vim.cmd
local api = vim.api

-- [[ File templates ]]
local templates = api.nvim_create_augroup("templates", { clear = true })
-- shell
api.nvim_create_autocmd("BufNewFile", {
	pattern = "*.sh",
	command = "0r ~/.config/nvim/templates/skeleton.sh | call feedkeys('ji')",
	group = templates,
})
-- latex
api.nvim_create_autocmd("BufNewFile", {
	pattern = "*.tex",
	command = "0r ~/.config/nvim/templates/skeleton.tex | call feedkeys('jjellciw')",
	group = templates,
})

-- [[ Formatting ]]
local formatting = api.nvim_create_augroup("formatting", { clear = true })
-- Clean up trailing spaces
api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	command = [[%s/\s\+$//e]],
	group = formatting,
})
-- prevent autocommenting new lines
api.nvim_create_autocmd("VimEnter", {
	pattern = "*",
	command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
	group = formatting,
})
-- make bulletpoints wrap nicely
api.nvim_create_autocmd("filetype", {
	pattern = "markdown",
	command = [[set linebreak breakindent showbreak =\ \ ]],
	group = formatting,
})

-- [[ Netrw preferences ]]
local Netrw = api.nvim_create_augroup("Netrw", { clear = true })
api.nvim_create_autocmd("filetype", {
	pattern = "netrw",
	group = Netrw,
	callback = function()
		-- close vim if netrw is the only open buffer
		cmd(
			"autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), '&filetype') == 'netrw' || &buftype == 'quickfix' |q|endif"
		)

		-- unfocus Netrw with <c-l>
		api.nvim_buf_set_keymap(0, "n", "<c-l>", "<c-w>l", { noremap = true, silent = true })

		-- open a vertical split for the currently selected file with V
		api.nvim_buf_set_keymap(0, "n", "V", "", {
			callback = function()
				cmd([[
                :normal v
                let g:path=expand('%:p')
                :q!
                execute 'vsplit' g:path
                :normal <c-l>
                :Lexplore
                ]])
			end,
			noremap = true,
			silent = true,
		})

		-- open a horizontal split for the currently selected file with H
		api.nvim_buf_set_keymap(0, "n", "H", "", {
			callback = function()
				cmd([[
                :normal v
                let g:path=expand('%:p')
                :q!
                execute 'split' g:path
                :normal <c-l>
                :Lexplore
                ]])
			end,
			noremap = true,
			silent = true,
		})
	end,
})
