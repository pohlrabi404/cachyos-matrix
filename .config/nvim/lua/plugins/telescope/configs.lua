local M = {}

M.setup = function()
	local customs = require("plugins.telescope.customs")
	require("telescope").setup({
		extensions = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			},

			file_browser = {
				auto_depth = true,
				mappings = {
					["i"] = {
						["C-p"] = customs.open_parent_folder,
					},
					["n"] = {
						["p"] = customs.open_parent_folder,
					},
				},
			},
		},
	})
end

M.mappings = function()
	local fb = require("plugins.telescope.customs")
	return {
		{ "<leader>ff", fb.find_files, desc = "[f]ind [f]iles" },
		{ "<leader>fb", fb.file_buffer, desc = "[f]ile [b]uffer" },
		{ "<leader>fg", fb.live_grep, desc = "[f]ile [g]rep" },
	}
end

return M
