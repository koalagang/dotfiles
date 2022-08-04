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

return packer.startup(function(use)
	-- reduce startup time
	use({
		{
			"lewis6991/impatient.nvim",
			config = function()
				require("impatient")
			end,
		},

		-- NOTE: this was merged into Neovim 0.8
		-- I will remove this plugin when that drops
		"nathom/filetype.nvim",

		{
			"tweekmonster/startuptime.vim",
			cmd = "StartupTime",
		},
	})

	-- let packer manage itself
	use("wbthomason/packer.nvim")

	-- dependencies which may be required by multiple plugins
	-- 'module' is used so that these plugins are only loaded when they are required by another plugin
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
		--cmd = {}
		requires = "nvim-lua/plenary.nvim",
		disable = true,
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
			-- TODO: migrate to mason.nvim
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
				-- TODO: write snippets in lua
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
		keys = { "f", "F", "<c-p>", "<leader>1" },
		branch = "v1",
	})

	-- fuzzy finder
	use({
		{
			"nvim-telescope/telescope.nvim",
			config = function()
				require("plugins.conf.telescope")
			end,
			cmd = "Telescope",
			branch = "0.1.x",
			requires = { "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons" },
			disable = true,
			-- EXTERNAL DEPENDENCIES: ripgrep, fd
		},

		{
			"nvim-telescope/telescope-fzf-native.nvim",
			--cmd = "Telescope",
			after = "telescope.nvim",
			run = "make",
			requires = "nvim-telescope/telescope.nvim",
			disable = true,
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
			after = "nvim-treesitter",
			requires = "nvim-treesitter/nvim-treesitter",
		},

		{
			"nvim-treesitter/nvim-treesitter-textobjects",
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

	-- move splits' borders with arrow keys
	use({
		"breuckelen/vim-resize",
		config = function()
			vim.cmd("let resize_count = 2")
		end,
		keys = { "<c-right>", "<c-left>", "<c-up>", "<c-down>" },
	})

	-- Automatically set up configuration after cloning packer.nvim
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
