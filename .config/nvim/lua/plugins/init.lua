local fn = vim.fn

-- Install packer if it is not already installed
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

-- Take a snapshot, re-source this file and then update the plugins
local plugins = vim.api.nvim_create_augroup("plugins", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "plugins.lua",
    command = "execute \"PackerSnapshot\" strftime('%Y-%m-%d_%H-%M') | source <afile> | PackerSync",
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

local languages = { "sh", "bib", "tex", "make", "rust", "toml", "lua", "nix", "markdown" }

return packer.startup(function(use)
    -- let packer manage itself
    use("wbthomason/packer.nvim")

    -- reduce startup time
    use({
        {
            "lewis6991/impatient.nvim",
            config = function()
                require("impatient")
            end,
        },

        {
            "tweekmonster/startuptime.vim",
            cmd = "StartupTime",
        },
    })

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
        -- only load gitsigns in this directory and all subdirectories
        event = "BufRead $HOME/Desktop/git*",
        requires = "nvim-lua/plenary.nvim",
    })

    -- note-taking
    -- I'm considering switching to nvim-neorg/neorg or nvim-orgmode/orgmode
    use({
        -- see lua/core/autocmds.lua for how I load vimwiki's config
        "vimwiki/vimwiki",
        -- only load vimwiki on markdown files in this directory and all subdirectories
        event = "BufNewFile,BufRead $HOME/Documents*.md",
    })

    -- LSP
    -- Configurations for Neovim's built-in language server client
    use({
        {
            "neovim/nvim-lspconfig",
            config = function()
                require("plugins.lsp.lsp")
            end,
            ft = languages,
        },

        {
            "williamboman/mason.nvim",
            config = function()
                require("mason").setup()
                require("mason-tool-installer").setup({
                    ensure_installed = {
                        "stylua",
                        "shellcheck",
                        "shfmt",
                    },
                })
            end,
            module = "mason",
            requires = {
                { "williamboman/mason-lspconfig.nvim", module = "mason-lspconfig" },
                { "WhoIsSethDaniel/mason-tool-installer.nvim", module = "mason-tool-installer" },
            },
            -- EXTERNAL DEPENDENCIES: tar gzip curl wget bash cargo
        },

        {
            -- Configurations for code formatters and linters
            -- This is not technically an LSP feature but it utilises neovim's LSP client
            "jose-elias-alvarez/null-ls.nvim",
            config = function()
                require("plugins.lsp.null-ls")
            end,
            ft = { "sh", "rust", "lua" },
            requires = "nvim-lua/plenary.nvim",
        },
    })

    -- Completion
    use({
        {
            "hrsh7th/nvim-cmp",
            event = "InsertEnter",
            config = function()
                require("conf.cmp")
            end,
        },

        { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
        { "hrsh7th/cmp-path", after = "nvim-cmp" },
        --{ "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
        { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },

        {
            "saadparwaiz1/cmp_luasnip",
            after = { "nvim-cmp", "LuaSnip" },
            --[[
            requires = {
                "L3MON4D3/LuaSnip",
                -- TODO: write snippets in lua
                require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/lua/plugins/snippets" } }),
            },
            ]]
        },

        {
            "L3MON4D3/LuaSnip",
            config = function()
                require("conf.luasnip")
            end,
        },

        {
            "hrsh7th/cmp-nvim-lua",
            ft = "lua", -- I can't figure out how to only load this under `~/.config/nvim/lua/*`
        },
    })

    --[[
    use({
        "L3MON4D3/LuaSnip",
        config = function()
            require("conf.luasnip")
        end,
    })
    ]]

    -- hop to any character in the current buffer
    use({
        "phaazon/hop.nvim",
        config = function()
            require("conf.hop")
        end,
        keys = { "f", "F", "<leader>1", "<leader>2" },
        branch = "v2",
    })

    -- fuzzy finder
    use({
        {
            "nvim-telescope/telescope.nvim",
            config = function()
                require("conf.telescope")
            end,
            cmd = "Telescope",
            branch = "0.1.x",
            requires = { "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons" },
            disable = true,
            -- EXTERNAL DEPENDENCIES: ripgrep fd
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
            require("conf.dracula")
        end,
    })

    -- treesitter syntax highlighting
    use({
        {
            "nvim-treesitter/nvim-treesitter",
            config = function()
                require("conf.treesitter")
            end,
            run = ":TSUpdate",
            ft = languages,
            -- EXTERNAL DEPENDENCIES: tar curl gcc
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
            require("conf.indent-blankline")
        end,
    })

    -- status line
    use({
        {
            "nvim-lualine/lualine.nvim",
            config = function()
                require("conf.lualine")
            end,
            after = "dracula.nvim",
            requires = "kyazdani42/nvim-web-devicons",
        },

        {
            "arkav/lualine-lsp-progress",
            before = "lualine.nvim",
            requires = "nvim-lualine/lualine.nvim",
        },
    })

    -- move split borders with ctrl + arrow keys
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
