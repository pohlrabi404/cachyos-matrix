return {
	---------- Telescope ----------
	"nvim-lua/plenary.nvim",
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("configs.telescope")
			require("telescope").load_extension("file_browser")
			require("telescope").load_extension("fzf")
		end,
	},

	"nvim-telescope/telescope-file-browser.nvim",

	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
	},

	---------- Theme ----------
	-- {
	-- 	"RRethy/base16-nvim",
	-- 	event = "UIEnter",
	-- 	config = function()
	-- 		require("base16-colorscheme").with_config({
	-- 			telescope = false,
	-- 		})
	-- 		vim.cmd("colorscheme base16-default-dark")
	-- 	end,
	-- },
	{
		"uga-rosa/ccc.nvim",
		event = "UIEnter",
		opts = {
			highlighter = {
				auto_enable = true,
				lsp = true,
			},
		},
	},
	--- NvchadUI ---
	{ "nvim-tree/nvim-web-devicons", lazy = true },
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

	---------- Notification ----------

	---------- Treesitter ----------
	{ "nvim-treesitter/nvim-treesitter" },

	---------- Formatter -----------
	{
		"stevearc/conform.nvim",
		event = { "UIEnter" },
		opts = require("configs.formatter").formatter,
	},
	---------- Lsp -----------
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = require("configs.lsp").lazydev,
	},
	{ "Bilal2453/luvit-meta", lazy = true },

	-- Main LSP Config --
	{
		"neovim/nvim-lspconfig",
		event = { "UIEnter" },
		dependencies = {
			{
				"williamboman/mason.nvim",
				cmd = { "Mason", "MasonInstall" },
				config = require("configs.lsp").masonconfig,
			},
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"hrsh7th/cmp-nvim-lsp",
			-- {
			-- 	"j-hui/fidget.nvim",
			-- 	event = "UIEnter",
			-- 	opts = {
			-- 		-- options
			-- 	},
			-- },
		},
		config = require("configs.lsp").lspconfig,
	},
	--------- Auto completions ----------
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				build = "make install_jsregexp",
				-- dependencies = {
				-- 	{
				-- 		"rafamadriz/friendly-snippets",
				-- 		config = function()
				-- 			require("luasnip.loaders.from_vscode").lazy_load()
				-- 		end,
				-- 	},
				-- },
			},
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
		},
		config = require("configs.completions").cmp,
	},

	-------- Which key ---------
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"<leader>/",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "buffer local keys",
			},
		},
	},
	----------- Git Things ---------
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
    cmd = {"Neogit"},
		opts = {},
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = require("configs.gitsigns"),
	},
	{
		"anuvyklack/hydra.nvim",
	},
}
