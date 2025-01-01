return {
	---------- Theme ----------
	{
		"stevearc/dressing.nvim",
		event = { "WinEnter" },
		opts = {},
	},
	{
		"uga-rosa/ccc.nvim",
		event = "User FilePost",
		opts = {
			highlighter = {
				auto_enable = true,
				lsp = true,
			},
		},
	},
	--- NvchadUI ---
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{
		"nvchad/ui",
		lazy = false,
		config = function()
			require("nvchad")
		end,
	},
	{
		"nvchad/base46",
		build = function()
			require("base46").load_all_highlights()
		end,
	},
	{
		"nvzone/volt",
	},

	---------- Treesitter ----------
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			dofile(vim.g.base46_cache .. "treesitter")
		end,
	},

	-------- Which key ---------
	{
		"folke/which-key.nvim",
		event = "User FilePost",
		opts = {},
	},
	----------- Git Things ---------
	{
		"lewis6991/gitsigns.nvim",
		event = "User FilePost",
		opts = require("configs.gitsigns").setup(),
	},

	---------- Mini ----------
	{
		"echasnovski/mini.nvim",
		event = "User FilePost",
		config = require("configs.mini").setup,
	},

	--- Autopairs ---
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = require("configs.autopairs").setup,
	},
	--- Session ---
	{
		"rmagatti/auto-session",
		event = "User FilePost",
		keys = require("configs.session").keys(),
		---enables autocomplete for opts
		---@module "auto-session"
		---@type AutoSession.Config
		opts = {
			suppressed_dirs = { "~/", "~/Downloads", "/" },
			-- log_level = 'debug',
		},
	},
}
