local map = vim.keymap.set

map("i", "<C-w><C-h>", "<C-\\><C-N><C-w><C-h>", { desc = "move left" })
map("i", "<C-w><C-j>", "<C-\\><C-N><C-w><C-j>", { desc = "move down" })
map("i", "<C-w><C-k>", "<C-\\><C-N><C-w><C-k>", { desc = "move up" })
map("i", "<C-w><C-l>", "<C-\\><C-N><C-w><C-l>", { desc = "move right" })

map("t", "<C-w><C-h>", "<C-\\><C-N><C-w><C-h>", { desc = "move left" })
map("t", "<C-w><C-j>", "<C-\\><C-N><C-w><C-j>", { desc = "move down" })
map("t", "<C-w><C-k>", "<C-\\><C-N><C-w><C-k>", { desc = "move up" })
map("t", "<C-w><C-l>", "<C-\\><C-N><C-w><C-l>", { desc = "move right" })

-- Exit terminal mode
map("t", "<C-e>", "<C-\\><C-N>")

map("n", "j", "jzz")
map("n", "k", "kzz")
map("n", "<c-d>", "<c-d>zz")

local term = require("nvchad.term")
map({ "n", "t" }, "<C-g>", function()
	term.toggle({
		id = "lazygit",
		pos = "float",
		cmd = "lazygit",
		float_opts = {
			row = 0,
			col = 0.5,
			width = 0.5,
			height = 0.9,
		},
	})
end, { desc = "Lazy Git" })

map({ "n", "t" }, "<C-t>", function()
	term.toggle({
		id = "term",
		pos = "sp",
	})
end, { desc = "Terminal" })

map("n", "<leader>/", function()
	require("which-key").show({ global = true })
end)

map("n", "<leader>ss", "<cmd>SessionSave<CR>", { desc = "[S]ave [s]ession" })
map("n", "<leader>st", "<cmd>SessionToggleAutoSave<CR>", { desc = "[s]ession [t]oggle autosave" })

AutoCmd("LspAttach", {
	group = AutoGroup("lsp-attach-mapping", { clear = true }),
	callback = function()
		local builtin = require("telescope.builtin")
		map("n", "gd", builtin.lsp_definitions, { desc = "[g]oto [d]efinitions" })
		map("n", "gr", builtin.lsp_references, { desc = "[g]oto [r]eferences" })
		map("n", "gi", builtin.lsp_implementations, { desc = "[g]oto [i]mplementations" })
		map("n", "<leader>td", builtin.lsp_type_definitions, { desc = "[t]ype [d]definitions" })
		map("n", "<leader>ds", builtin.lsp_document_symbols, { desc = "[d]oc [s]ymbols" })
		map("n", "<leader>ws", builtin.lsp_workspace_symbols, { desc = "[w]ork [s]ymbols" })
		map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[r]e[n]ame" })
		map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[c]ode [a]ction" })
		map("n", "gD", vim.lsp.buf.declaration, { desc = "[g]oto [D]eclaration" })
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
