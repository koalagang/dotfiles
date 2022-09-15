local ls = require("luasnip")
local types = require("luasnip.util.types")

require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets/" })

ls.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
    --[[
    ext_opts = {
        [require("luasnip.util.types").choiceNode] = {
            active = {
                virt_text = { { "<--", "Error" } },
            },
        },
    },
    ]]
})

local keymap = vim.keymap.set

keymap({ "i", "s" }, "<m-j>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end)
keymap({ "i", "s" }, "<m-k>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end)

keymap({ "i", "s" }, "<m-l>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end)
keymap({ "i", "s" }, "<m-h>", function()
    if ls.choice_active() then
        ls.change_choice(-1)
    end
end)
