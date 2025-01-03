local M = {}

M.init = function(filetype, func)
	AutoCmd("FileType", {
		pattern = filetype,
		callback = function()
			vim.schedule(func)
		end,
	})
end

return M
