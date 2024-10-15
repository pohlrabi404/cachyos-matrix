function set(m, k, f, st)
  settings = { silent = true, noremap = false } 
  if st ~= nil then
    for key, value in pairs(st) do settings[key] = value end
  end
  vim.keymap.set(m, k, f, st)
end

set('n', '<leader>ff', '<cmd>Telescope file_browser path=%:p:h select_buffer=false<CR>')
set('n', '<leader>fg', '<cmd>Telescope live_grep<CR>')
set('n', '<leader>fb', '<cmd>Telescope buffers<CR>') 
set('n', '<Esc>', '<cmd>nohlsearch<CR><Esc>' , { noremap = true })
set('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
set('n', '<leader>wf', '<cmd>WikiPages<cr>')
