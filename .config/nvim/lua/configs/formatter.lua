local M = {}

M.formatter = {
	formatters_by_ft = {
		lua = { "stylua" },
	},
	format_on_save = {
		timeout_ms = 500,
	},
}

return M
