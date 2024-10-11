function set(m, k, f, d, rm)
  rm = rm or false
  vim.keymap.set(m, k, f, { desc = d, silent = true, noremap = rm })
end

set("n", "<space>ff", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")
set('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', 'Telescope Find files')
set('n', '<leader>fb', '<cmd>Telescope buffers<CR>', 'Telescope Buffers') 
set('n', '<Esc>', '<cmd>nohlsearch<CR><Esc>', 'Clear search', true)

