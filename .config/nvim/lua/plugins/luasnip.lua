local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node
local f = ls.function_node
local r = ls.repeat_node
local sn = ls.snippet_node
local fmt = require("luasnip.extras.fmt").fmt

ls.config.set_config({
	history = true,
	enable_autosnippets = true,
})

ls.add_snippets("all", {
	---
	-- format snippet
	s(
		"snipf",
		fmt(
			[[
    <>({ trig='<>', name='<>', dscr='<>'},
    fmt(<>,
    { <> },
    { delimiters='<>' }
    )<>)<>,]],
			{
				c(1, { t("s"), t("autosnippet") }),
				i(2, "trig"),
				i(3, "trig"),
				i(4, "dscr"),
				i(5, "fmt"),
				i(6, "inputs"),
				i(7, "<>"),
				i(8, "opts"),
				i(0),
			},
			{ delimiters = "<>" }
		)
	),

	-- simple text snippet
	s(
		"snipt",
		fmt(
			[[
    <>(<>, {t('<>')}<>
    <>)<>,]],
			{
				c(1, { t("s"), t("autosnippet") }),
				c(2, { i(nil, "trig"), sn(nil, { t("{trig='"), i(1), t("'}") }) }),
				i(3, "text"),
				i(4, "opts"),
				i(5),
				i(0),
			},
			{ delimiters = "<>" }
		)
	),
	---
}, {
	type = "autosnippets",
})

ls.add_snippets("markdown", {
	--- python code block
	s(
		{
			trig = ";nb",
			name = "Python Code Block",
		},
		fmt(
			[[
  ```python
    {}
  ```]],
			{ i(0) }
		)
	),
	--- abstract block
	s(
		{ trig = "nabs", name = "abstract", dscr = "Abstract block" },
		fmt(
			[[
  > [!ABSTRACT]{}
  > {}]],
			{ i(1), i(0) },
			{ delimiters = "{}" }
		)
	),
	---
}, {
	type = "autosnippets",
})
