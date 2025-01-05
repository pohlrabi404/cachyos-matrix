return {
	dir = "~/projects/nvim/plugins/md-latex",
	name = "md-latex",
	init = function()
		AutoCmd("FileType", {
			pattern = "markdown",
			once = true,
			callback = function()
				vim.schedule(function()
					require("md-latex").setup()
				end)
			end,
		})
	end,
}
