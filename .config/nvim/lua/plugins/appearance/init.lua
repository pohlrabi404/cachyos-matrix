local M = {
	---------- Theme ----------
	{
		"stevearc/dressing.nvim",
		event = { "User FilePost" },
		opts = {},
	},
	{
		"uga-rosa/ccc.nvim",
		-- ft = { "lua", "css" },
		init = function()
			AutoCmd("FileType", {
				pattern = { "lua", "css" },
				callback = function()
					vim.schedule(function()
						require("ccc")
					end)
				end,
			})
		end,
		opts = {
			highlighter = {
				auto_enable = true,
				lsp = true,
			},
		},
	},
	--- NvchadUI ---
	{
		"nvim-tree/nvim-web-devicons",
		opts = function()
			dofile(vim.g.base46_cache .. "devicons")
			return {}
		end,
	},
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
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "User FilePost",
		opts = {
			indent = { char = "│", highlight = "IblChar" },
			scope = { char = "│", highlight = "IblScopeChar" },
		},
		config = require("plugins.appearance.ibl").config,
	},
	{
		"folke/which-key.nvim",
		opts = {},
		event = "User FilePost",
	},
}

return M
