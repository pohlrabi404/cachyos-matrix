--- Git Hydra
local hydra_git = function()
	local gitsigns = require("gitsigns")
	local hint = [[
 _J_: next hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line
 _K_: prev hunk   _u_: undo last stage   _p_: preview hunk   
 ^ ^              _S_: stage buffer      ^ ^                 
 ^
 ^ ^              _<Enter>_: Neogit              _q_: exit
]]
	local ret = {
		name = "Git",
		hint = hint,
		config = {
			buffer = bufnr,
			color = "pink",
			invoke_on_body = true,
			hint = {
				border = "rounded",
			},
			on_enter = function()
				vim.cmd("mkview")
				vim.cmd("silent! %foldopen!")
				vim.bo.modifiable = false
				gitsigns.toggle_signs(true)
				gitsigns.toggle_linehl(true)
			end,
			on_exit = function()
				local cursor_pos = vim.api.nvim_win_get_cursor(0)
				vim.cmd("loadview")
				vim.api.nvim_win_set_cursor(0, cursor_pos)
				vim.cmd("normal zv")
				gitsigns.toggle_signs(false)
				gitsigns.toggle_linehl(false)
				gitsigns.toggle_deleted(false)
			end,
		},
		mode = { "n", "x" },
		body = "<leader>g",
		heads = {
			{
				"J",
				function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gitsigns.nav_hunk("next")
					end)
					return "<Ignore>"
				end,
				{ expr = true, desc = "next hunk" },
			},
			{
				"K",
				function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gitsigns.nav_hunk("prev")
					end)
					return "<Ignore>"
				end,
				{ expr = true, desc = "prev hunk" },
			},
			{ "s", gitsigns.stage_hunk, { silent = true, desc = "stage hunk" } },
			{ "u", gitsigns.undo_stage_hunk, { desc = "undo last stage" } },
			{ "S", gitsigns.stage_buffer, { desc = "stage buffer" } },
			{ "p", gitsigns.preview_hunk, { desc = "preview hunk" } },
			{ "d", gitsigns.toggle_deleted, { nowait = true, desc = "toggle deleted" } },
			{ "b", gitsigns.toggle_current_line_blame, { desc = "toggle blame", delay = 100 } },
			{ "<Enter>", "<Cmd>Neogit<CR>", { exit = true, desc = "Neogit" } },
			{ "q", nil, { exit = true, nowait = true, desc = "exit" } },
		},
	}
  return ret
end

-- Hydra main function
local hydra = {
	"anuvyklack/hydra.nvim",
	event = "VeryLazy",
	config = function()
		local Hydra = require("hydra")
		Hydra(hydra_git())
	end,
}

return { hydra }
