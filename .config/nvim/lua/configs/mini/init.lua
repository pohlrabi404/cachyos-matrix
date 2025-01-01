local M = {}
M.setup = function()
	local autocmd = vim.api.nvim_create_autocmd
	local group = vim.api.nvim_create_augroup("Mini", { clear = true })

	autocmd({ "BufEnter" }, {
		group = group,
		once = true,
		callback = function()
			require("mini.move").setup(M.move())
		end,
	})

	autocmd({ "ModeChanged" }, {
		group = group,
		once = true,
		callback = function()
			require("mini.ai").setup(M.ai())
		end,
	})

	autocmd({ "ModeChanged" }, {
		group = group,
		once = true,
		callback = function()
			require("mini.surround").setup(M.surround())
		end,
	})
end

M.surround = function()
	return {}
end

M.ai = function()
	return {}
end

M.move = function()
	return {
		mappings = {
			-- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
			left = "<M-h>",
			right = "<M-l>",
			down = "<M-j>",
			up = "<M-k>",

			-- Move current line in Normal mode
			line_left = "<M-h>",
			line_right = "<M-l>",
			line_down = "<M-j>",
			line_up = "<M-k>",
		},
	}
end

return M
