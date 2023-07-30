require("lualine").setup({
    options = {
        -- `dracula-nvim` requires Mofiqul/dracula.nvim
        -- For normal dracula theme, simply use `dracula`
        theme = "dracula-nvim",
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = true,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" }, -- diagnostics requires LSP
        lualine_c = { "filename" },
        lualine_x = {
            {
                -- lsp_progress requires arkav/lualine-lsp-progress
                "lsp_progress",
                display_components = { "lsp_client_name", { "percentage" } },
            },
            "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { { "%l/%L" } },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = {},
})
