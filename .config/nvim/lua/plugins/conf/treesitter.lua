require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "bash",
        "bibtex",
        "latex",
        "make",
        "markdown",
        "rust",
        "toml",
        "lua",
        "nix",
    },
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
    highlight = {
        -- `false` will disable the whole extension
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
    -- vim has built-in smart indentation and these seem to cancel each other out for some reason
    -- so disable the built-in smart indentation if you want to use this option
    indent = { enable = false },

    -- requires "p00f/nvim-ts-rainbow"
    rainbow = {
        enable = true,
        --disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        --colors = {}, -- table of hex strings
        --termcolors = {} -- table of colour name strings
    },

    -- requires "nvim-treesitter/nvim-treesitter-textobjects"
    textobjects = {
        select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
            --[[
            swap = {
                enable = true,
                swap_next = { ["<leader>xp"] = "@parameter.inner" },
                swap_previous = { ["<leader>xP"] = "@parameter.inner" },
            },
            lsp_interop = {
                enable = true,
                border = "none",
                peek_definition_code = {
                    ["<leader>pf"] = "@function.outer",
                    ["<leader>pc"] = "@class.outer",
                },
            },
            ]]
        },
    },
})
