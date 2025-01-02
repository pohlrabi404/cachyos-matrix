local config = function()
	--- subjective to change for other mapping
	require("leap").create_default_mappings()
end
local keys = function()
	return {
		{
			"gn",
			function()
				require("leap.treesitter").select()
			end,
			{ "n", "x", "o" },
			desc = "[g]rab [n]ode",
		},
	}
end
return {
	"ggandor/leap.nvim",
	dependencies = { "tpope/vim-repeat" },
	event = "User FilePost",
	config = config,
	keys = keys,
}
