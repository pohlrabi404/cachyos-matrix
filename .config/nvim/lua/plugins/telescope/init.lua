local config = function()
	dofile(vim.g.base46_cache .. "telescope")
	require("plugins.telescope.configs").setup()
	require("telescope").load_extension("file_browser")
	require("telescope").load_extension("fzf")
end

local M = {
	---------- Telescope ----------
	"nvim-lua/plenary.nvim",
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		cmd = "Telescope",
		event = "User FilePost",
		config = config,
	},

	"nvim-telescope/telescope-file-browser.nvim",

	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
	},
}

return M
