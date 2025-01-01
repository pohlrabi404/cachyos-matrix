return {
	---------- Theme ----------
	{
		"stevearc/dressing.nvim",
		event = { "WinEnter" },
		opts = {},
	},
	{
		"uga-rosa/ccc.nvim",
		event = "User FilePost",
		opts = {
			highlighter = {
				auto_enable = true,
				lsp = true,
			},
		},
	},
	--- NvchadUI ---
	{
		"nvim-tree/nvim-web-devicons",
		opts = function()
			dofile(vim.g.base46_cache .. "devicons")
			return {}
		end,
	},
	{
		"nvchad/ui",
		lazy = false,
		config = function()
			require("nvchad")
		end,
	},
	{
		"nvchad/base46",
		build = function()
			require("base46").load_all_highlights()
		end,
	},
	{
		"nvzone/volt",
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "User FilePost",
		opts = {
			indent = { char = "│", highlight = "IblChar" },
			scope = { char = "│", highlight = "IblScopeChar" },
		},
		config = function(_, opts)
			dofile(vim.g.base46_cache .. "blankline")

			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
			require("ibl").setup(opts)

			dofile(vim.g.base46_cache .. "blankline")
		end,
	},

	---------- Treesitter ----------
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			dofile(vim.g.base46_cache .. "treesitter")
		end,
	},

	-------- Which key ---------
	{
		"folke/which-key.nvim",
		event = "User FilePost",
		opts = function()
			dofile(vim.g.base46_cache .. "whichkey")
			return {}
		end,
	},
	----------- Git Things ---------
	{
		"lewis6991/gitsigns.nvim",
		event = "User FilePost",
		opts = require("configs.gitsigns").setup(),
	},

	---------- Mini ----------
	{
		"echasnovski/mini.nvim",
		event = "User FilePost",
		config = require("configs.mini").setup,
	},

	--- Autopairs ---
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = require("configs.autopairs").setup,
	},
	--- Session ---
	{
		"rmagatti/auto-session",
		event = "User FilePost",
		cmd = "SessionRestore",
		keys = require("configs.session").keys(),
		---enables autocomplete for opts
		---@module "auto-session"
		---@type AutoSession.Config
		opts = {
			suppressed_dirs = { "~/", "~/Downloads", "/" },
			-- log_level = 'debug',
		},
	},
	{
		{
			"abecodes/tabout.nvim",
			config = function()
				require("tabout").setup({
					tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
					backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
					act_as_tab = true, -- shift content if tab out is not possible
					act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
					default_tab = "<C-Tab>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
					default_shift_tab = "<S-Tab>", -- reverse shift default action,
					enable_backwards = true, -- well ...
					completion = false, -- if the tabkey is used in a completion pum
					tabouts = {
						{ open = "'", close = "'" },
						{ open = '"', close = '"' },
						{ open = "`", close = "`" },
						{ open = "(", close = ")" },
						{ open = "[", close = "]" },
						{ open = "{", close = "}" },
					},
					ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
					exclude = {}, -- tabout will ignore these filetypes
				})
			end,
			dependencies = { -- These are optional
				"nvim-treesitter/nvim-treesitter",
				"L3MON4D3/LuaSnip",
				"hrsh7th/nvim-cmp",
			},
			event = "User FilePost", -- Set the event to 'InsertCharPre' for better compatibility
		},
	},
}
