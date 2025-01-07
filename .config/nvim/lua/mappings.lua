local map = vim.keymap.set
-- Moving around between windows
map("n", "<Esc>", "<Esc><cmd>nohlsearch<CR>")

-- Exit terminal mode
map("t", "<C-e>", "<C-\\><C-N>")

map("n", "j", "jzz")
map("n", "k", "kzz")
map("n", "<c-d>", "<c-d>zz")

map("i", "<c-;>", "<Esc>A;")
map("i", "<c-,>", "<Esc>A,")

local term = require("nvchad.term")
map({ "n", "t" }, "<localleader>g", function()
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

map({ "n", "t" }, "<localleader>t", function()
	term.toggle({
		id = "term",
		pos = "sp",
	})
end, { desc = "Terminal" })

map("n", "<leader>ss", "<cmd>SessionSave<CR>", { desc = "[S]ave [s]ession" })
map("n", "<leader>st", "<cmd>SessionToggleAutoSave<CR>", { desc = "[s]ession [t]oggle autosave" })

map({ "n", "x", "o" }, "gn", function()
	require("leap.treesitter").select()
end, { desc = "[g]rab [n]ode" })

map("n", "<leader>/", function()
	require("which-key").show({ global = true })
end, { desc = "show local mappings" })

map("n", "<leader>?", function()
	require("which-key").show({ global = false })
end, { desc = "show global mappings" })
