-- Appearance
local terminal = require('lualine.themes.horizon')
for key, value in pairs(terminal) do
  terminal[key].c.fg = '#00b000'
  terminal[key].b.fg = '#00f000'
end
require('lualine').setup({
  options = { theme = terminal },
})

-- Base16
require('base16-colorscheme').with_config({
  telescope = false,
})
require('base16-colorscheme').setup({
  base00 = '#000000',
  base01 = '#1b1b1b',
  base02 = '#363636',
  base03 = '#515151',
  base04 = '#6c6c6c',
  base05 = '#878787',
  base06 = '#a2a2a2',
  base07 = '#bdbdbd',
  base08 = '#ff6666',
  base09 = '#ffa366',
  base0A = '#ffff66',
  base0B = '#00ff00',
  base0C = '#66ffff',
  base0D = '#66b3ff',
  base0E = '#ff66ff',
  base0F = '#ffb366'
})
