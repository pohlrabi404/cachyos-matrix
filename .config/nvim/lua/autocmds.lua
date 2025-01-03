-- user event that loads after UIEnter + only if file buf is there
AutoCmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
	group = AutoGroup("NvFilePost", { clear = true }),
	callback = function(args)
		local file = vim.api.nvim_buf_get_name(args.buf)
		local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

		if not vim.g.ui_entered and args.event == "UIEnter" then
			vim.g.ui_entered = true
		end

		if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
			ExeAutoCmd("User", { pattern = "FilePost", modeline = false })
			vim.api.nvim_del_augroup_by_name("NvFilePost")

			vim.schedule(function()
				ExeAutoCmd("FileType", {})

				if vim.g.editorconfig then
					require("editorconfig").config(args.buf)
				end
			end)
		end
	end,
})

local map = vim.keymap.set

AutoCmd("LspAttach", {
	group = AutoGroup("lsp-attach-mapping", { clear = true }),
	callback = function()
		local builtin = require("telescope.builtin")
		map("n", "gd", builtin.lsp_definitions, { desc = "[g]oto [d]efinitions" })
		map("n", "gr", builtin.lsp_references, { desc = "[g]oto [r]eferences" })
		map("n", "gi", builtin.lsp_implementations, { desc = "[g]oto [i]mplementations" })
		map("n", "gtd", builtin.lsp_type_definitions, { desc = "[t]ype [d]definitions" })
		map("n", "gds", builtin.lsp_document_symbols, { desc = "[d]oc [s]ymbols" })
		map("n", "gws", builtin.lsp_workspace_symbols, { desc = "[w]ork [s]ymbols" })
		map("n", "gD", vim.lsp.buf.declaration, { desc = "[g]oto [D]eclaration" })
		map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[r]e[n]ame" })
		map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[c]ode [a]ction" })
	end,
})

AutoCmd("User", {
	pattern = "telescope-mapping",
	callback = function()
		local fb = require("plugins.telescope.customs")
		map("n", "<leader>ff", fb.find_files, { desc = "[f]ind [f]iles" })
		map("n", "<leader>fb", fb.file_buffer, { desc = "[f]ile [b]uffer" })
		map("n", "<leader>fg", fb.live_grep, { desc = "[f]ile [g]rep" })
	end,
})

AutoCmd("User", {
	pattern = "MoltenKernelReady",
	callback = function()
		require("quarto").activate()
		local runner = require("quarto.runner")
		map("n", "<localleader>rc", runner.run_cell, { desc = "run cell", silent = true })
		map("n", "<localleader>ra", runner.run_above, { desc = "run cell and above", silent = true })
		map("n", "<localleader>rA", runner.run_all, { desc = "run all cells", silent = true })
		map("n", "<localleader>rl", runner.run_line, { desc = "run line", silent = true })
		map("v", "<localleader>r", runner.run_range, { desc = "run visual range", silent = true })
		map("n", "<localleader>RA", function()
			runner.run_all(true)
		end, { desc = "run all cells of all languages", silent = true })
	end,
})
