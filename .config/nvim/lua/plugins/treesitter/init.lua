local config = function()
	dofile(vim.g.base46_cache .. "treesitter")
	require("nvim-treesitter.configs").setup({
		ensure_installed = { "lua", "markdown", "markdown_inline", "python", "latex" },
		sync_install = true,
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
	})
end

return {
	"nvim-treesitter/nvim-treesitter",
	config = config,
}
