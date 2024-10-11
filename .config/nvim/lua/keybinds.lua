function set(m, k, f, d, rm)
  rm = rm or false
  vim.keymap.set(m, k, f, { desc = d, silent = true, noremap = rm })
end

set('n', '<leader>ff', '<cmd>Telescope find_files<CR>', 'Telescope Find files')
set('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', 'Telescope Find files')
set('n', '<leader>fb', '<cmd>Telescope buffers<CR>', 'Telescope Buffers') 
set('n', '<Esc>', '<cmd>nohlsearch<CR><Esc>', 'Clear search', true)
