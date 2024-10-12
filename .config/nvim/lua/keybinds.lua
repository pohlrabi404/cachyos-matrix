function set(m, k, f, st)
  settings = { silent = true, noremap = false } 
  if st ~= nil then
    for key, value in pairs(st) do settings[key] = value end
  end
  vim.keymap.set(m, k, f, st)
end

set('n', '<space>ff', ':Telescope file_browser path=%:p:h select_buffer=true<CR>')
set('n', '<leader>fg', '<cmd>Telescope live_grep<CR>')
set('n', '<leader>fb', '<cmd>Telescope buffers<CR>') 
set('n', '<Esc>', '<cmd>nohlsearch<CR><Esc>' , { noremap = true })
set('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
