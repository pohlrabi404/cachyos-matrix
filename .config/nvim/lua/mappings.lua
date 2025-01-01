local map = vim.keymap.set

local builtin = require("telescope.builtin")
local fb = require("configs.telescope.custom")

map("n", "<leader>fg", builtin.live_grep, { desc = "[f]ile [g]rep" })
map("n", "<leader>fb", fb.file_buffer, { desc = "[f]ile [b]uffer" })
map("n", "<leader>ft", builtin.help_tags, { desc = "[f]ind [h]elps" })
map("n", "<leader>ff", fb.find_files, { desc = "[f]ind [f]ile" })

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

-- lazygit
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
