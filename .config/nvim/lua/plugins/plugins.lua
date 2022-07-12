local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer. Close and re-open Neovim...")
	vim.cmd([[packadd packer.nvim]])
end
-- EXTERNAL DEPENDENCIES: git

-- Autocommand that reloads neovim whenever you save the plugins.lua file
local plugins = vim.api.nvim_create_augroup("plugins", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "plugins.lua",
	command = "source <afile> | PackerSync",
	group = plugins,
})

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- disable built-in plugins
local disabled_built_ins = {
	-- I like to use netrw instead of something like nerdtree or nvim-tree
	--[[
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    ]]
	"gzip",
	"zip",
	"zipPlugin",
	"tar",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",
	"logipat",
	"rrhelper",
	"spellfile_plugin",
	"matchit",
}
for _, plugin in pairs(disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end

--local languages = { "sh", "bib", "cs", "kotlin", "tex", "make", "markdown", "python", "rust", "toml", "lua" }
local languages = { "sh", "bib", "tex", "rust", "toml", "lua" }

--[[ TODO:
Consider installing:
lewis6991/foldsigns.nvim
mattn/emmet-vim
numToStr/Comment.nvim
iamcco/markdown-preview.nvim

Git:
tpope/vim-fugitive
tpope/vim-rhubarb
tpope/vim-repeat
OR
TimUntersberger/neogit
sindrets/diffview.nvim

Create luasnippets: https://youtube.com/watch?v=ub0REXjhpmk

I still need to figure out how to lazy-load the following:
LuaSnip (probably the solution it switch from vscode snippets to luasnippets)
cmp-nvim-lua
]]

return packer.startup(function(use)
	-- reduce startup time by caching lua modules
	use({
		"lewis6991/impatient.nvim",
		config = function()
			require("impatient")
		end,
	})

	-- let packer manage itself
	use("wbthomason/packer.nvim")

	-- dependencies which may be required by multiple plugins
	-- 'module' is used so that plugins are only loaded when they are required by another plugin
	use({
		{
			"nvim-lua/plenary.nvim",
			module = "plenary",
		},

		{
			"kyazdani42/nvim-web-devicons",
			module = "nvim-web-devicons",
		},
	})

	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
		-- I will add more commands as I explore Gitsigns more
		cmd = { "Gitsigns get_hunks" },
		requires = "nvim-lua/plenary.nvim",
	})

	-- note-taking
	-- I'm considering switching to nvim-neorg/neorg or nvim-orgmode/orgmode
	use({
		"vimwiki/vimwiki",
		config = function()
			require("plugins.conf.vimwiki")
		end,
		ft = "markdown",
	})

	-- LSP
	-- Configurations for Neovim's built-in language server client
	use({
		{
			"neovim/nvim-lspconfig",
			config = function()
				require("plugins.lsp")
			end,
			ft = languages,
		},

		{
			"williamboman/nvim-lsp-installer",
			ft = languages,
			-- would be nice if there was an :LspUpdate command
			-- I might submit an issue to nvim-lsp-installer
			-- TODO: set up a file with `ensure_installed`
			--run = ':LspInstall bashls kotlin_language_server pyright rust_analyzer sumneko_lua texlab zeta_note'
			-- EXTERNAL DEPENDENCIES: tar, gzip, curl, wget, bash, npm3, pip3
		},

		{
			-- Configurations for code formatters and linters
			-- This is not technically an LSP feature but it utilises neovim's LSP client
			"jose-elias-alvarez/null-ls.nvim",
			ft = languages,
			requires = "nvim-lua/plenary.nvim",
		},
	})

	-- Completion
	use({
		{
			"hrsh7th/nvim-cmp",
			event = "InsertEnter",
			config = function()
				require("plugins.conf.cmp")
			end,
		},

		{ "hrsh7th/cmp-buffer", after = "nvim-cmp" },
		{ "hrsh7th/cmp-path", after = "nvim-cmp" },
		{ "hrsh7th/cmp-cmdline", after = "nvim-cmp", ft = languages },
		{ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp", ft = languages },

		{
			"saadparwaiz1/cmp_luasnip",
			after = { "nvim-cmp", "LuaSnip" },
			requires = {
				"L3MON4D3/LuaSnip",
				-- I might need to modify how I manage my snippets in order to lazy-load LuaSnip
				-- i.e. not use vscode snippets
				require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/lua/plugins/snippets" } }),
			},
		},

		{
			"hrsh7th/cmp-nvim-lua",
			ft = "lua",
			after = "nvim-cmp",
		},
	})

	-- hop to any character in the current buffer
	use({
		"phaazon/hop.nvim",
		config = function()
			require("plugins.conf.hop")
		end,
		branch = "v1",
		keys = { "f", "F", "<c-p>", "<leader>1" },
	})

	-- fuzzy finder
	use({
		{
			"nvim-telescope/telescope.nvim",
			config = function()
				require("plugins.conf.telescope")
			end,
			cmd = "Telescope",
			requires = { "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons" },
			-- EXTERNAL DEPENDENCIES: ripgrep, fd
		},

		{
			"nvim-telescope/telescope-fzf-native.nvim",
			cmd = "Telescope",
			run = "make",
			requires = "nvim-telescope/telescope.nvim",
		},
	})

	-- dracula colour scheme
	use({
		"Mofiqul/dracula.nvim",
		config = function()
			require("plugins.conf.dracula")
		end,
	})

	-- treesitter syntax highlighting
	use({
		{
			"nvim-treesitter/nvim-treesitter",
			config = function()
				require("plugins.conf.treesitter")
			end,
			run = ":TSUpdate",
			ft = languages,
			-- EXTERNAL DEPENDENCIES: tar, curl, gcc
		},

		{
			"p00f/nvim-ts-rainbow",
			config = function()
				require("plugins.conf.treesitter")
			end,
			after = "nvim-treesitter",
			requires = "nvim-treesitter/nvim-treesitter",
		},
	})

	-- preview hex colours
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
		cmd = "ColorizerToggle",
	})

	-- indent lines
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("plugins.conf.indent-blankline")
		end,
	})

	-- status line
	use({
		"nvim-lualine/lualine.nvim",
		config = function()
			require("plugins.conf.lualine")
		end,
		after = "dracula.nvim",
		requires = "kyazdani42/nvim-web-devicons",
	})

	-- Automatically set up configuration after cloning packer.nvim
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
