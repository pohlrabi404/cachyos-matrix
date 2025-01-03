---@diagnostic disable: undefined-global
return {
	s(
		{ trig = ";cb", snippetType = "autosnippet" },
		fmt( -- The snippet code actually looks like the equation environment it produces.
			[[
      ```{python}
      <>
      ```
    ]],
			-- The insert node is placed in the <> angle brackets
			{ i(1) },
			-- This is where I specify that angle brackets are used as node positions.
			{ delimiters = "<>" }
		)
	),
}
