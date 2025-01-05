local M

M = {
	base46 = {
		theme = "chadracula",
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
			{
				txt = "  Find File",
				keys = "ff",
				cmd = "Telescope file_browser",
			},
			{ txt = "  Recent Files", keys = "fo", cmd = "Telescope oldfiles" },
			{ txt = "󰈭  Find Word", keys = "fg", cmd = "Telescope live_grep" },
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
			enabled = false,
		},
	},
}

return M
