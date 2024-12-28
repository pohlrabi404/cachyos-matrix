---@diagnostic disable: missing-fields
local which_key = {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")
		wk.setup({
			preset = "helix",
		})
		wk.add({
			{ "<leader>f", group = "File", icon = "" },
			{ "<leader>fb", icon = "", desc = "File Buffer" },
			{ "<leader>ff", icon = "", desc = "Find File" },
			{ "<leader>fg", icon = "󰛔", desc = "Live Grep" },

			{ "<leader>c", group = "Code", icon = "" },
			{ "<leader>cf", icon = "󰸱", desc = "Code Formating" },
			{ "<leader>ch", icon = "", desc = "Code Hover" },
			{ "<leader>cd", icon = "󰳾", desc = "Code Definition" },
			{ "<leader>ca", icon = "", desc = "Code Actions" },

			{ "<leader>d", group = "Debug", icon = "" },
			{ "<leader>db", icon = "", desc = "Set Breakpoint" },
			{ "<leader>dpr", icon = "", desc = "Run Python Debugger" },

			{ "<A-h>", "<C-w>h", group = "Move Window", desc = "Move Left" },
			{ "<A-j>", "<C-w>j", group = "Move Window", desc = "Move Down" },
			{ "<A-k>", "<C-w>k", group = "Move Window", desc = "Move Up" },
			{ "<A-l>", "<C-w>l", group = "Move Window", desc = "Move Right" },

			{ "<leader>/", icon = "", desc = "Show All" },
		})
	end,
	keys = {
		{
			"<leader>/",
			function()
				require("which-key").show({ global = true })
			end,
		},
	},
}

return { which_key }
