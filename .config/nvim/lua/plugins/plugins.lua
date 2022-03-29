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
    -- ripgrep, fd (telescope)
    -- tar, curl, gcc (treesitter)
-- TODO:
    -- Install language servers for lua, python, bash - and go or rust (?)
    -- Configure lazy-loading (cmd, ft, etc.)
    -- Read through nvim-treesitter, nvim-lspconfig, nvim-cmp and packer.nvim documentation
    -- Consider installing the following??
	-- lewis6991/gitsigns.nvim
	-- akinsho/bufferline.nvim
    -- tpope/vim-repeat
]]

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
    "matchit"
}
for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end


local languages = { 'sh', 'bib', 'c', 'cs', 'go', 'kotlin', 'tex', 'make', 'markdown', 'python', 'rust', 'toml', 'vim', 'lua' }

return packer.startup(function(use)
    -- let packer manage itself
    use { 'wbthomason/packer.nvim', opt = false }


    -- note-taking
    use {
        'vimwiki/vimwiki',
        config = function() require('plugins.conf.vimwiki') end,
        ft = 'markdown'
    }
    -- hologram thinks my vimwiki notes are vim files, even thoug they're markdown files
    -- :set ft? also says vimwiki
    --use {'edluffy/hologram.nvim', ft = 'markdown', opt = true }


    -- LSP
    -- Configurations for Neovim's built-in language server client
    -- TODO: install and configure LSP for lua, bash, python, kotlin, csharp, rust and/or go
    use {
            {
                'neovim/nvim-lspconfig',
                config = function() require('plugins.lsp') end,
                ft = languages
            },

            {
                'williamboman/nvim-lsp-installer',
                ft = languages
            }
        }


    -- Completion
    use {
            {
                'hrsh7th/nvim-cmp',
                config = function() require('plugins.conf.cmp') end,
                requires = {
                    'L3MON4D3/LuaSnip',
                    require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/lua/plugins/snippets" } })
                }
            },

            { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },

            {
                'saadparwaiz1/cmp_luasnip',
                after = 'nvim-cmp',
                requires = { 'hrsh7th/nvim-cmp', 'L3MON4D3/LuaSnip' }
            },

            {
                'hrsh7th/cmp-nvim-lua',
                after = 'nvim-cmp',
                ft = 'lua'
            }

    }


    -- hop to any character in the current buffer
    use {
            'phaazon/hop.nvim',
            config = function() require'hop'.setup() end,
            branch = 'v1',
            cmd = { 'HopWord', 'HopPattern' }
        }


    -- fuzzy finder
    use {
            {
                'nvim-telescope/telescope.nvim',
                config = function() require 'plugins.conf.telescope' end,
                module = 'telescope',
                cmd = 'Telescope',
                requires = {
                    -- I can't seem to get plenary to lazy-load even if telescope does
                    'nvim-lua/plenary.nvim',
                    module = 'telescope'
                }
            },

            {
                'nvim-telescope/telescope-fzf-native.nvim',
                module = 'telescope',
                cmd = 'Telescope',
                run = 'make'
            }
    }


    -- dracula colour scheme
    use {
            'Mofiqul/dracula.nvim',
            config = function() require('plugins.conf.dracula') end
            -- don't lazy-load dracula
            -- that causes nvim-ts-rainbow to stop working
        }


    -- treesitter syntax highlighting
    use {
            {
                'nvim-treesitter/nvim-treesitter',
                config = function() require('plugins.conf.treesitter') end,
                event = 'BufWinEnter',
                run = ':TSUpdate',
                ft = languages
            },

            {
                'p00f/nvim-ts-rainbow',
                config = function() require('plugins.conf.treesitter') end,
                after = 'nvim-treesitter',
                requires = 'nvim-treesitter/nvim-treesitter'
            }
        }


    -- preview hex colours
    use {
            'norcalli/nvim-colorizer.lua',
            config = function() require'colorizer'.setup() end,
            cmd = 'ColorizerToggle'
        }


    -- indent lines
    use {
            'lukas-reineke/indent-blankline.nvim',
            config = function() require('plugins.conf.indent-blankline') end,
            event = 'BufWinEnter'
        }


    -- status line
    use {
            'nvim-lualine/lualine.nvim',
            config = function() require('plugins.conf.lualine') end,
            after = 'dracula.nvim',
                requires = {
                    'kyazdani42/nvim-web-devicons',
                    opt = true
                }
        }


    -- Automatically set up configuration after cloning packer.nvim
    if PACKER_BOOTSTRAP then
    require('packer').sync()
    end
end)
