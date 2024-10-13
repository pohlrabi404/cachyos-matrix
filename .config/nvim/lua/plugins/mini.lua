return {
  { 'echasnovski/mini.nvim', version = false,
    config = function()
      require('mini.ai').setup() 
      require('mini.icons').setup()
      require('mini.completion').setup()
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
    end
  },
}
