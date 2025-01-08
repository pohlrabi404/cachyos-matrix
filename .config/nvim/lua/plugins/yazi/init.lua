return {
	---@type LazySpec
	{
		"mikavilpas/yazi.nvim",
		event = "VeryLazy",
		keys = {
			-- 👇 in this section, choose your own keymappings!
			{
				"<leader>fc",
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
			{
				-- Open in the current working directory
				"<leader>ff",
				"<cmd>Yazi cwd<cr>",
				desc = "Open the file manager in nvim's working directory",
			},
		},
		---@module "yazi"
		---@type YaziConfig
		opts = {
			floating_window_scaling_factor = 0.80,
			integrations = {
				grep_in_directory = function(directory)
					local fzf = require("fzf-lua")
					fzf.live_grep({ cwd = directory })
				end,
			},
			keymaps = {
				show_help = "<leader>/",
			},
		},
	},
}
