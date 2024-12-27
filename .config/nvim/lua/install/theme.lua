local colorizer = {
	"norcalli/nvim-colorizer.lua",
  event = "VeryLazy",
  config = function ()
    require("colorizer").setup()
  end,
}

local lualine = {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
	opts = function(_, opts)
		local terminal = require("lualine.themes.horizon")

		for key, _ in pairs(terminal) do
			terminal[key].c.fg = "#00b000"
			terminal[key].b.fg = "#00f000"
		end

		opts.options = { theme = terminal }
	end,
}

local color_scheme = {
	"RRethy/base16-nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("base16-colorscheme").with_config({
			telescope = false,
		})
		require("base16-colorscheme").setup({
			base00 = "#000000",
			base01 = "#1b1b1b",
			base02 = "#363636",
			base03 = "#515151",
			base04 = "#6c6c6c",
			base05 = "#00ff00",
			base06 = "#ffffff",
			base07 = "#ffffff",
			base08 = "#ff0044",
			base09 = "#ff6666",
			base0A = "#ffff66",
			base0B = "#ff7700",
			base0C = "#00ffff",
			base0D = "#666bff",
			base0E = "#ff33ff",
			base0F = "#ffb366",
		})
	end,
}

return { colorizer, lualine, color_scheme }
