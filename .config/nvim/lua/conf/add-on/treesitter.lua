require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
    -- allow only bash, bibtex, c, c_sharp, comment, go, kotlin, latex, make, markdown, python, rust, toml, vim and lua
    -- they should probably add a whitelist option as well
    ignore_install = {
        "beancount",
        "clojure",
        "cmake",
        "comment",
        "commonlisp",
        "cooklang",
        "cpp",
        "css",
        "cuda",
        "d",
        "dart",
        "devicetree",
        "dockerfile",
        "dot",
        "eex",
        "elixir",
        "erlang",
        "fennel",
        "fish",
        "foam",
        "fortra",
        "fusion",
        "gleam",
        "glimmer",
        "glsl",
        "gdscript",
        "gomod",
        "gowork",
        "graphql",
        "hack",
        "haskell",
        "hcl",
        "heex",
        "hjson",
        "hocon",
        "html",
        "http",
        "java",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "json5",
        "julia",
        "lalrpop",
        "ledger",
        "llvm",
        "ninja",
        "nix",
        "norg",
        "ocaml",
        "ocaml_interface",
        "ocamllex",
        "pascal",
        "perl",
        "php",
        "phpdoc",
        "pioasm",
        "prisma",
        "pug",
        "ql",
        "query",
        "r",
        "rasi",
        "regex",
        "rst",
        "ruby",
        "scala",
        "scss",
        "slint",
        "solidity",
        "sparql",
        "supercollider",
        "surface",
        "svelte",
        "swift",
        "teal",
        "tlaplus",
        "todotxt",
        "tsx",
        "turtle",
        "typescript",
        "vala",
        "verilog",
        "vue",
        "yaml",
        "yang",
        "zig"
    },
    highlight = {
        -- `false` will disable the whole extension
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false
    },
    -- requires p00f/nvim-ts-rainbow
    rainbow = {
        enable = true,
        --disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        --colors = {}, -- table of hex strings
        --termcolors = {} -- table of colour name strings
  }
}
