local luasnip = {
	"L3MON4D3/LuaSnip",
  build = "make install_jsregexp",
	dependencies = {
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
	},
	event = { "InsertEnter" },
}
return { luasnip }
