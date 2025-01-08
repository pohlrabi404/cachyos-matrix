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
		---@module "fzf-lua.config"
		opts = {
			winopts = {
				height = 0.80,
				width = 0.80,
				row = 0.5,
				col = 0.5,
			},
			preview = {},
		},
	},
}
