-- Mini
require('mini.ai').setup() 
require('mini.icons').setup()
require('mini.jump2d').setup({
  mappings = {
    start_jumping = ';;'
  }
})
require('mini.notify').setup()
require('mini.pairs').setup()
require('mini.sessions').setup({
  autoread = true
})
require('mini.splitjoin').setup()
require('mini.clue').setup({
  triggers = {
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },
  },
})
require('mini.surround').setup({
  custom_surroundings = {
    [';'] = { output = { left = '[[', right = ']]'} },
  },
})
