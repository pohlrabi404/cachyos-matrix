local map = vim.keymap.set

local builtin = require('telescope.builtin')
local fb = require('customs.telescope')

map('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
map('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
map('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
map('n', '<leader>ff', fb.find_files, { desc = 'Telescope find files' })
