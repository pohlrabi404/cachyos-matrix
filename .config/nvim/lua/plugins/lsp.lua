return {
	---------- Lsp -----------
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{
					path = "luvit-meta/library",
					words = { "vim%.uv" },
				},
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },

	-- Main LSP Config --
	{
		"neovim/nvim-lspconfig",
		event = { "User FilePost" },
		dependencies = {
			{
				"williamboman/mason.nvim",
				cmd = { "Mason", "MasonInstall" },
				config = function()
					dofile(vim.g.base46_cache .. "mason")
					require("configs.lsp").masonconfig()
				end,
			},
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = require("configs.lsp").lspconfig,
	},
	--------- Auto completions ----------
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				build = "make install_jsregexp",
			},
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
		},
		config = require("configs.completions").cmp,
	},

	---------- Formatter -----------
	{
		"stevearc/conform.nvim",
		event = { "User FilePost" },
		opts = require("configs.formatter").formatter,
	},
}
