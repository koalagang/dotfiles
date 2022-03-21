local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path, }
  print "Installing packer close and re-open Neovim..."
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
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- TODO:
-- Install LSPs for lua, python, bash - and go or rust (?)
-- Disable built-in plugins (?)
-- Read through nvim-lspconfig, nvim-cmp and packer.nvim documentation
-- Consider installing the following??
    -- nvim-telescope/telescope.nvim
    -- lewis6991/gitsigns.nvim
    -- nvim-treesitter/nvim-treesitter
    -- kyazdani42/nvim-tree.lua
    -- akinsho/toggleterm.nvim
    -- molleweide/LuaSnip-snippets.nvim
-- NOTE: Try not to go too hard with the plugins and make sure to use lazy-loading

return packer.startup(function(use)
    --[[Plugins]]

    -- explicitly install packer to avoid accidentally uninstalling
    use { 'wbthomason/packer.nvim', opt = false }

    use 'lukas-reineke/indent-blankline.nvim'

    -- I may move to feline (?)
    use { 'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons'}}

    use { 'vimwiki/vimwiki', ft = 'markdown', opt = true }

    -- Snippets
    -- TODO: create snippets
    use { 'L3MON4D3/LuaSnip', ft = { 'tex', 'bib', 'sh', 'py', 'lua' }, opt = true }

    -- LSP
    -- TODO: configure lsp
    use {{'neovim/nvim-lspconfig'},
        {'williamboman/nvim-lsp-installer'}}

    -- completion
    use {{'hrsh7th/nvim-cmp'},  -- The completion plugin
        {'hrsh7th/cmp-buffer'}, -- buffer completions
        {'hrsh7th/cmp-path'},   -- path completions
        {'hrsh7th/cmp-cmdline'},-- cmdline completions
        {'hrsh7th/cmp-nvim-lsp'}}
    use {'saadparwaiz1/cmp_luasnip', -- snippet completions
        requires = {'hrsh7th/nvim-cmp', 'L3MON4D3/LuaSnip'}}

    -- can't seem to get colorizer working without using an ugly colour scheme (termguicolors), will try again later
    --use 'norcalli/nvim-colorizer.lua'
    use 'ap/vim-css-color' -- will use vim-css-color in the meantime

    -- Automatically set up configuration after cloning packer.nvim
    if PACKER_BOOTSTRAP then
    require("packer").sync()
    end
end)

--[[ Commands
Regenerate compiled loader file
-- :PackerCompile

Remove any disabled or unused plugins
-- :PackerClean

Clean, then install missing plugins
-- :PackerInstall

Clean, then update and install plugins
-- :PackerUpdate

Perform `PackerUpdate` and then `PackerCompile`
-- :PackerSync

Loads opt plugin immediately
-- :PackerLoad completion-nvim ale
]]
