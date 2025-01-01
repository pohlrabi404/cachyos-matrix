local M = {}

M.keys = function()
	return {
		-- Will use Tlescope if installed or a vim.ui.select picker otherwise
		{ "<leader>sr", "<cmd>SessionRestore<CR>", desc = "[s]ession [r]estore" },
		{ "<leader>ss", "<cmd>SessionSave<CR>", desc = "[S]ave [s]ession" },
		{ "<leader>st", "<cmd>SessionToggleAutoSave<CR>", desc = "[s]ession [t]oggle autosave" },
	}
end

return M
