local config = function()
	dofile(vim.g.base46_cache .. "telescope")
	require("plugins.telescope.configs").setup()
	require("telescope").load_extension("file_browser")
	require("telescope").load_extension("fzf")
end

local keys = require("plugins.telescope.configs").mappings

local M = {
	---------- Telescope ----------
	"nvim-lua/plenary.nvim",
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		keys = keys,
		cmd = "Telescope",
		config = config,
	},

	"nvim-telescope/telescope-file-browser.nvim",

	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
	},
}

return M
