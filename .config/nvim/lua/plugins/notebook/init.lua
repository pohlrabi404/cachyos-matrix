local autocmd = require("plugins.notebook.autocmds").init
return {
	{
		--- mdmath
		"Thiago4532/mdmath.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		opts = require("plugins.notebook.mdmath").opts,
		init = function()
			autocmd({ "markdown" }, function()
				require("mdmath").setup()
			end)
		end,
	},

	--- quarto
	{
		"quarto-dev/quarto-nvim",
		dependencies = {
			"jmbuhr/otter.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function(_, opts)
			require("quarto").setup(opts)
		end,
		opts = {
			lspFeatures = {
				languages = { "python" },
				enabled = true,
				chunks = "all",
				diagnostics = {
					enabled = true,
					triggers = { "BufWritePost" },
				},
				completion = { enabled = true },
			},
			codeRunner = {
				enabled = true,
				default_method = "molten",
			},
		},
	},

	--- molten
	{
		"benlubas/molten-nvim",
		build = {
			[[python -m venv ~/.virtualenvs/neovim &&
      source ~/.virtualenvs/neovim/bin/activate &&
      pip install pynvim jupyter_client]],
			":UpdateRemotePlugins",
		},
		dependencies = { "image.nvim" },
		init = function()
			vim.g.python3_host_prog = vim.fn.expand("~/.virtualenvs/neovim/bin/python3")
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_open_output = true
			vim.g.molten_wrap_output = true
			vim.g.molten_virt_text_output = true
			vim.g.molten_virt_lines_off_by_1 = true
		end,
	},

	{
		"3rd/image.nvim",
		---@module "image"
		---@type ImageOptions
		opts = {
			backend = "kitty",
			processor = "magick_rock",
			integration = {
				markdown = {
					enabled = true,
					floating_windows = true,
					filetypes = { "markdown", "quarto" },
				},
			},
			max_width = 100, -- tweak to preference
			max_height = 10, -- ^
			max_height_window_percentage = math.huge, -- this is necessary for a good experience
			max_width_window_percentage = math.huge,
			window_overlap_clear_enabled = true,
			window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
		},
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
		init = function()
			AutoCmd("FileType", {
				pattern = "markdown",
				callback = function()
					vim.schedule(function()
						require("render-markdown").setup()
					end)
				end,
			})
		end,

		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			preset = "obsidian",
			latex = {
				enabled = true,
			},
			code = {
				style = "full",
				left_pad = 2,
			},
		},
	},
}
