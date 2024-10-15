-- Appearance
local terminal = require('lualine.themes.horizon')
for key, value in pairs(terminal) do
  terminal[key].c.fg = '#00b000'
  terminal[key].b.fg = '#00f000'
end
require('lualine').setup({
  options = { theme = terminal },
})
