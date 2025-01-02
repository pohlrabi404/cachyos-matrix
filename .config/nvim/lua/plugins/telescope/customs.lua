local M = {}

M.live_grep = function()
  local builtin = require("telescope.builtin")
  builtin.live_grep({
    max_results = 20
  })
end

M.find_files = function()
  local fb = require("telescope").extensions.file_browser
	fb.file_browser({
		path = vim.fn.expand("%:p:h"), -- Start in the directory of the current file
		select_buffer = false, -- Do not select the buffer after opening
		hidden = true,
		respect_gitignore = false, 
    auto_depth = true,
		grouped = true,
    max_results = 20,
	})
end

-- Adding delete for file buffer
M.file_buffer = function()
  local action_state = require("telescope.actions.state")
  local buffers = require("telescope.builtin").buffers
	buffers({
		initial_mode = "normal",
		attach_mappings = function(prompt_bufnr, map)
			local delete_buf = function()
				local current_picker = action_state.get_current_picker(prompt_bufnr)
				current_picker:delete_selection(function(selection)
					vim.api.nvim_buf_delete(selection.bufnr, { force = true })
				end)
			end

			map("n", "d", delete_buf)

			return true
		end,
	}, {
		sort_lastused = true,
		sort_mru = true,
	})
end

--- Helper function
M.open_parent_folder = function(prompt_bufnr)
  print("what the fuck")
  local fb_actions = require("telescope").extensions.file_browser.actions
  local action_state = require("telescope.actions.state")
	local entry = action_state.get_selected_entry()
	local parent_dir = vim.fn.fnamemodify(entry.path, ":h")
	if parent_dir == "" then
		fb_actions.goto_parent_dir(prompt_bufnr)
	else
		fb_actions.open_dir(prompt_bufnr, _, parent_dir)
	end
end

return M
