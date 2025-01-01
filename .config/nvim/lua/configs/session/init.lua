local M = {}

M.keys = function()
	return {
		-- Will use Tlescope if installed or a vim.ui.select picker otherwise
		{ "<leader>ss", "<cmd>SessionSave<CR>", desc = "[S]ave [s]ession" },
		{ "<leader>st", "<cmd>SessionToggleAutoSave<CR>", desc = "[s]ession [t]oggle autosave" },
	}
end

return M
