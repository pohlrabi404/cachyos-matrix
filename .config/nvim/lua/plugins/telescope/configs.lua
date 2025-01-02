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

	ExeAutoCmd("User", {
		pattern = "telescope-mapping",
	})
end

return M
