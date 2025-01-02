local config = function()
	--- subjective to change for other mapping
	require("leap").create_default_mappings()
end

return {
	"ggandor/leap.nvim",
	dependencies = { "tpope/vim-repeat" },
	event = "User FilePost",
	config = config,
}
