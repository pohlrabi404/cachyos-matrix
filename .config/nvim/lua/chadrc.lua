local M

M = {
	base46 = {
		theme = "ayu_dark",
		transparency = true,
	},

	telescope = { style = "bordered" },

	statusline = {
		theme = "minimal",
		separator_style = "round",
	},

	lsp = { signature = true },

	nvdash = {
		load_on_startup = true,
		header = {
			"   ▄███████▄  ▄██████▄     ▄█    █▄     ▄█          ▄████████    ▄████████ ▀█████████▄   ▄█  ",
			"  ███    ███ ███    ███   ███    ███   ███         ███    ███   ███    ███   ███    ███ ███  ",
			"  ███    ███ ███    ███   ███    ███   ███         ███    ███   ███    ███   ███    ███ ███▌ ",
			"  ███    ███ ███    ███  ▄███▄▄▄▄███▄▄ ███        ▄███▄▄▄▄██▀   ███    ███  ▄███▄▄▄██▀  ███▌ ",
			"▀█████████▀  ███    ███ ▀▀███▀▀▀▀███▀  ███       ▀▀███▀▀▀▀▀   ▀███████████ ▀▀███▀▀▀██▄  ███▌ ",
			"  ███        ███    ███   ███    ███   ███       ▀███████████   ███    ███   ███    ██▄ ███  ",
			"  ███        ███    ███   ███    ███   ███▌    ▄   ███    ███   ███    ███   ███    ███ ███  ",
			" ▄████▀       ▀██████▀    ███    █▀    █████▄▄██   ███    ███   ███    █▀  ▄█████████▀  █▀   ",
			"                                       ▀           ███    ███                                ",
			"                                                                                             ",
			"                                                                                             ",
		},

		buttons = {
			{ txt = "  Restore Session", keys = "sr", cmd = "SessionRestore" },
			{ txt = "  Find File", keys = "ff", cmd = "Telescope find_files" },
			{ txt = "  Recent Files", keys = "fo", cmd = "Telescope oldfiles" },
			{ txt = "󰈭  Find Word", keys = "fw", cmd = "Telescope live_grep" },
			{ txt = "󱥚  Themes", keys = "th", cmd = ":lua require('nvchad.themes').open()" },

			{ txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },

			{
				txt = function()
					local stats = require("lazy").stats()
					local ms = math.floor(stats.startuptime) .. " ms"
					return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
				end,
				hl = "NvDashFooter",
				no_gap = true,
			},

			{ txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
		},
	},

	ui = {
		tabufline = {
			enabled = false,
		},
		cmp = {
			icons_left = false,
			style = "flat_dark",
		},
	},
}

return M
