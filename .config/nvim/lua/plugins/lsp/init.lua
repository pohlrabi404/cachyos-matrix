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

	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
}
