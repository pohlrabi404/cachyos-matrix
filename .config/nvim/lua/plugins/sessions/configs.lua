local M = {}

M.opts = function(_, opts)
	opts = opts or {}
	local custom_opts = {
		suppressed_dirs = {
			"~/",
			"~/Downloads",
			"/",
		},
	}
	return vim.tbl_deep_extend("force", opts, custom_opts)
end

M.mappings = function()
	return {
		{ "<leader>ss", "<cmd>SessionSave<CR>", desc = "[S]ave [s]ession" },
		{ "<leader>st", "<cmd>SessionToggleAutoSave<CR>", desc = "[s]ession [t]oggle autosave" },
	}
end

return M
