local M = {}

M.init = function(filetype, func)
	AutoCmd("FileType", {
		pattern = filetype,
		callback = function(args)
			local buf = args.buf
			if not vim.api.nvim_get_option_value("modifiable", { buf = buf }) then
				return
			end
			vim.schedule(func)
		end,
	})
end

return M
