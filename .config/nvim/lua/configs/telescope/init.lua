local M = {}

M.setup = function()
	local custom = require("configs.telescope.custom")
	require("telescope").setup({
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			},
			file_browser = {
				auto_depth = true,
				mappings = {
					["i"] = {
						["<C-p>"] = custom.open_parent_folder,
					},
					["n"] = {
						["p"] = custom.open_parent_folder,
					},
				},
			},
		},
	})
end

return M
