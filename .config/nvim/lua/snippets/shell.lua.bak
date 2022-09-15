local ls = require("luasnip")

-- This is a snippet creator
-- s(<trigger>, <nodes>)
local s = ls.s

-- This is a format node.
-- It takes a format string, and a list of nodes
-- fmt(<fmt_string>, {...nodes})
local fmt = require("luasnip.extras.fmt").fmt

-- This is an insert node
-- It takes a position (like $1) and optionally some default text
-- i(<position>, [default_text])
local i = ls.insert_node

-- Repeats a node
-- rep(<position>)
local rep = require("luasnip.extras").rep

return {
	shell = {
		s("if", fmt("if [ {} ]; then\n\t{}\nfi"), { i(1), i(0) }),
	},
}

--[[
"if_posix": {
  "prefix": "if",
  "body": "if [ ${2:condition} ]; then\n\t${1}$0\nfi",
  "description": "A POSIX-compliant IF statement."
},
]]
