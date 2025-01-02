return {
	--- Mason ---
	"williamboman/mason-lspconfig.nvim",
	"mason-tool-installer.nvim",
	"hrsh7th/cmp-nvim-lsp",
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall" },
		config = function()
			dofile(vim.g.base46_cache .. "mason")
			require("mason").setup()
		end,
	},

	{
		"neovim/nvim-lspconfig",
		event = "User FilePost",
		config = require("plugins.lsp.mason").config,
	},
}
