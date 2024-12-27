local which_key = {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "helix",
	},
	keys = {
		{
			"?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}

return { which_key }
