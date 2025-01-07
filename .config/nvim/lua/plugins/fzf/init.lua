return {
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = "FzfLua",
		event = "User FilePost",
		config = function(_, opts)
			require("fzf-lua").setup(opts)
			ExeAutoCmd("User", {
				pattern = "Fzf",
			})
		end,

		---@class fzf-lua
		opts = {},
	},
}
