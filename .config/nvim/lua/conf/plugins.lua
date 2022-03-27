local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path, }
  print 'Installing packer. Close and re-open Neovim...'
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
}

--[[
-- Dependencies not managed by packer:
    -- git (to automatically install packer)
    -- xclip (to copy data to system clipboard)
    -- tar, gzip, curl, wget, python3, node, bash, npm3, pip3 (lsp-installer)
    -- ripgrep (telescope)
    -- tar, curl, gcc (treesitter)
-- TODO:
    -- Install language servers for lua, python, bash - and go or rust (?)
    -- Configure lazy-loading (cmd, ft, etc.)
    -- Read through nvim-treesitter, nvim-lspconfig, nvim-cmp and packer.nvim documentation
    -- Consider installing the following??
	-- lewis6991/gitsigns.nvim
	-- akinsho/bufferline.nvim
]]

return packer.startup(function(use)
    --[[Plugins]]

    -- let packer manage itself
    use { 'wbthomason/packer.nvim', opt = false }
    -- indent lines
    use { 'lukas-reineke/indent-blankline.nvim', config = function() require('conf.add-on.indent-blankline') end }

    use { 'nvim-lualine/lualine.nvim', config = function() require('conf.add-on.lualine') end,
        requires = {'kyazdani42/nvim-web-devicons'}}

    -- Note-taking
    use { 'vimwiki/vimwiki', ft = 'markdown', config = function() require('conf.add-on.vimwiki') end }
    -- hologram thinks my vimwiki notes are vim files, even thoug they're markdown files
    -- set ft? also says vimwiki
    --use {'edluffy/hologram.nvim', ft = 'markdown', opt = true }

    -- LSP
    -- TODO: install and configure LSP for lua, bash, python, kotlin, csharp, rust and/or go
    use {{ 'neovim/nvim-lspconfig', config = function() require('conf.add-on.lsp') end },
        { 'williamboman/nvim-lsp-installer' }}

    -- Completion
    use {{'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-cmdline' },
        { 'hrsh7th/cmp-nvim-lsp', config = function() require('conf.add-on.cmp') end },
        { 'hrsh7th/cmp-nvim-lua', ft = 'lua' }}
    use { 'saadparwaiz1/cmp_luasnip', requires = { 'hrsh7th/nvim-cmp', 'L3MON4D3/LuaSnip' }}

    -- Snippets
    use { 'L3MON4D3/LuaSnip', require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/lua/conf.add-on/snippets" } })}

    -- Navigation
    use { 'phaazon/hop.nvim', branch = 'v1', config = function() require'hop'.setup() end }
    -- TODO: install and configure telescope
    --use { 'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim' }
    --[[
    use { "nvim-telescope/telescope-frecency.nvim",
      config = function() require"telescope".load_extension("frecency") end,
      requires = {"tami5/sqlite.lua"} }
      ]]

    -- Colour
    use { 'Mofiqul/dracula.nvim', config = function() require('conf.add-on.dracula') end }
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate',
        ft = { 'sh', 'bib', 'c', 'cs', 'go', 'kotlin', 'tex', 'make', 'markdown', 'python', 'rust', 'toml', 'vim', 'lua' },
    config = function() require('conf.add-on.treesitter') end }
    use { 'p00f/nvim-ts-rainbow', config = function() require('conf.add-on.treesitter') end,
        ft = { 'sh', 'bib', 'c', 'cs', 'go', 'kotlin', 'tex', 'make', 'markdown', 'python', 'rust', 'toml', 'vim', 'lua' },
        requires = 'nvim-treesitter/nvim-treesitter' }
    use { 'norcalli/nvim-colorizer.lua', cmd = 'ColorizerToggle', config = function() require'colorizer'.setup() end }

    -- Automatically set up configuration after cloning packer.nvim
    if PACKER_BOOTSTRAP then
    require('packer').sync()
    end
end)
