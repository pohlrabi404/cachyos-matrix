local luasnip = {
	"L3MON4D3/LuaSnip",
	dependencies = {
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
	},
}
local latex_snip = {
	"iurimateus/luasnip-latex-snippets.nvim",
	-- vimtex isn't required if using treesitter
	requires = { "L3MON4D3/LuaSnip" },
	config = function()
		require("luasnip-latex-snippets").setup({ use_treesitter = true })
		require("luasnip").config.setup({ enable_autosnippets = true })
	end,
}
return { luasnip, latex_snip }
