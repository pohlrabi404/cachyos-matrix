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

return M
