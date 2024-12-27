local mdmath = {
	"Thiago4532/mdmath.nvim",
  event = "VeryLazy",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		dynamic_scale = 0.7,
	},
  ft = "markdown",
}

return mdmath
