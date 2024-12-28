local neogit = {
	"NeogitOrg/neogit",
  event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration

		-- Only one of these is needed.
		"nvim-telescope/telescope.nvim", -- optional
	},
	opts = {},
}

local gitsigns = {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
  opts = {},
}

return { neogit, gitsigns }
