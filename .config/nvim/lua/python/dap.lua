local nvim_dap = {
	"mfussenegger/nvim-dap",
  event = "VeryLazy",
}
local dap_ui = {
	"rcarriga/nvim-dap-ui",
	dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	config = function()
		local dap = require("dap")
		local ui = require("dapui")
		ui.setup()
		dap.listeners.after.event_initialized["dapui_config"] = function()
			ui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			ui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			ui.close()
		end
	end,
	keys = {
		{ "<leader>db", "<cmd> DapToggleBreakpoint<CR>", desc = "Toggle Break Point", mode = "n" },
	},
}

--- Python DAP
local python_dap = {
	"mfussenegger/nvim-dap-python",
	dependencies = { dap_ui[1], nvim_dap[1] },
	config = function()
		local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python3"
		require("dap-python").setup(path)
	end,
	keys = {
		{ "<leader>dpr", function ()
		  require("dap-python").test_method()
		end, desc = "Toggle Break Point", mode = "n" },
	},
}

return { nvim_dap, dap_ui, python_dap }
