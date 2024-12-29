local M = {}

require("telescope").load_extension("file_browser")
local fb = require("telescope").extensions.file_browser
local fb_actions = require('telescope').extensions.file_browser.actions

M.find_files = function()
  require('telescope').extensions.file_browser.file_browser({
    path = vim.fn.expand('%:p:h'),  -- Start in the directory of the current file
    select_buffer = false,          -- Do not select the buffer after opening
    hidden = true,                  -- Include hidden files (optional)
    respect_gitignore = false,       -- Respect .gitignore (optional)
    auto_depth = true,
  })
end

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

M.open_parent_folder = function(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  local parent_dir = vim.fn.fnamemodify(entry.path, ":h")
  if parent_dir == "" then
    fb_actions.goto_parent_dir(prompt_bufnr)
  else
    local picker = action_state.get_current_picker(prompt_bufnr)
    fb_actions.open_dir(prompt_bufnr, _, parent_dir)
  end
end

return M
