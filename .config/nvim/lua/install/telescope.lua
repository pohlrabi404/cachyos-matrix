local telescope = {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			},
			file_browser = {
				auto_depth = true,
			},
		},
	},
	keys = {
		{
			"<leader>fb",
			function()
				local builtin = require("telescope.builtin")
				local action_state = require("telescope.actions.state")

				builtin.buffers({
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
					theme = "dropdown",
				})
			end,
      desc = "Open File Buffer"
		},
    {
      "<leader>ff",
      "<cmd>Telescope file_browser path=%:p:h select_buffer=false<CR>",
      desc = "Open File Browser"
    },
    {
      "<leader>fg",
      "<cmd>Telescope live_grep<CR>",
      desc = "Live Grep"
    }
	},
}

local file_browser = {
	"nvim-telescope/telescope-file-browser.nvim",
	dependencies = { telescope[1], "nvim-lua/plenary.nvim" },
	config = function()
		require("telescope").load_extension("file_browser")
	end,
}

local fzf = {
	"nvim-telescope/telescope-fzf-native.nvim",
	build = "make",
	dependencies = { telescope[1] },
	config = function()
		require("telescope").load_extension("fzf")
	end,
}

return { telescope, fzf, file_browser }
