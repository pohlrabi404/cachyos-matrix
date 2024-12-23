return {
	-- Telescope
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},

	-- Mini
	{
		"echasnovski/mini.nvim",
		version = false,
	},

	-- Appearance
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"RRethy/base16-nvim",
	},

	-- Obsidian
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
  -- Wiki
  {
    "lervag/wiki.vim",
  },

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},

	-- Completions
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets"
		},
	},
	{
		"hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp"
	},

	-- Image in neovim
	{
		"edluffy/hologram.nvim",
	},

	-- Mason
	{
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},
	{
		"nvimtools/none-ls.nvim",
	},

  -- Autosave
  {
    "Pocco81/auto-save.nvim",
  },
}
