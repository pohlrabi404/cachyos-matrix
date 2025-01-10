local M = {}

M.opts = function(_, opts)
	opts = opts or {}
	local custom_opts = {
		filetypes = { "markdown", "quarto" },
		dynamic_scale = 1.0,
		hide_on_insert = true,
		anticonceal = true,
		update_interval = 200,
		internal_scale = 2,
	}
	return vim.tbl_deep_extend("force", opts, custom_opts)
end

return M
