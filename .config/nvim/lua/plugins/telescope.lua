-- Telescope setup
require('telescope').setup({
    extensions = {
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                         -- the default case_mode is "smart_case"
      },
      file_browser = {
        auto_depth = true,
      },
    }
  })
require('telescope').load_extension('fzf')    
require('telescope').load_extension('file_browser')

-- Telescope close buffer
local builtin = require('telescope.builtin')
local action_state = require('telescope.actions.state')

TelescopeBuffer = function()
  builtin.buffers({
    initial_mode = "normal",
    attach_mappings = function(prompt_bufnr, map)
      local delete_buf = function()
        local current_picker = action_state.get_current_picker(prompt_bufnr)
        current_picker:delete_selection(function(selection)
          vim.api.nvim_buf_delete(selection.bufnr, { force = true })
        end)
      end

      map('n', 'd', delete_buf)

      return true
    end
  }, {
    sort_lastused = true,
    sort_mru = true,
    theme = "dropdown"
  })
end
