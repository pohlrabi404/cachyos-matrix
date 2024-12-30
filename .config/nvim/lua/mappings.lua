local map = vim.keymap.set

local builtin = require("telescope.builtin")
local fb = require("customs.telescope")

map("n", "<leader>fg", builtin.live_grep, { desc = "[f]ile [g]rep" })
map("n", "<leader>fb", fb.file_buffer, { desc = "[f]ile [b]uffer" })
map("n", "<leader>ft", builtin.help_tags, { desc = "[f]ind [h]elps" })
map("n", "<leader>ff", fb.find_files, { desc = "[f]ind [f]ile" })

map("n", "<A-h>", "<C-w><C-h>", { desc = "move left" })
map("n", "<A-j>", "<C-w><C-j>", { desc = "move down" })
map("n", "<A-k>", "<C-w><C-k>", { desc = "move up" })
map("n", "<A-l>", "<C-w><C-l>", { desc = "move right" })

map("i", "<A-h>", "<C-\\><C-N><C-w><C-h>", { desc = "move left" })
map("i", "<A-j>", "<C-\\><C-N><C-w><C-j>", { desc = "move down" })
map("i", "<A-k>", "<C-\\><C-N><C-w><C-k>", { desc = "move up" })
map("i", "<A-l>", "<C-\\><C-N><C-w><C-l>", { desc = "move right" })

map("t", "<A-h>", "<C-\\><C-N><C-w><C-h>", { desc = "move left" })
map("t", "<A-j>", "<C-\\><C-N><C-w><C-j>", { desc = "move down" })
map("t", "<A-k>", "<C-\\><C-N><C-w><C-k>", { desc = "move up" })
map("t", "<A-l>", "<C-\\><C-N><C-w><C-l>", { desc = "move right" })

-- Exit terminal mode
map("t", "<C-e>", "<C-\\><C-N>")

map("n", "j", "jzz")
map("n", "k", "kzz")
map("n", "<c-d>", "<c-d>zz")
