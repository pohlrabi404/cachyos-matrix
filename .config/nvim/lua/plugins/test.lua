function set(m, k, f, st)
  settings = { silent = true, noremap = false } 
  if st ~= nil then
    for key, value in pairs(st) do settings[key] = value end
  end
  vim.keymap.set(m, k, f, st)
end
