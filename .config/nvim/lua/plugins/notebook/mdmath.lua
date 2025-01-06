local M = {}

M.opts = function(_, opts)
	opts = opts or {}
	local custom_opts = {
		filetypes = { "markdown", "quarto" },
		dynamic_scale = 0.7,
		update_interval = 200,
		internal_scale = 2,
	}
	return vim.tbl_deep_extend("force", opts, custom_opts)
end

return M
