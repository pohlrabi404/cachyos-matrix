local config = function()
	dofile(vim.g.base46_cache .. "treesitter")
end

return {
	"nvim-treesitter/nvim-treesitter",
	config = config,
}
