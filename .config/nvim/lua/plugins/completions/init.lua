return {
	"saghen/blink.cmp",
	version = "*",
	dependencies = { "L3MON4D3/LuaSnip", version = "v2.*" },
	config = function(_, opts)
		opts = opts or {}
		dofile(vim.g.base46_cache .. "cmp")
		require("blink.cmp").setup(opts)
	end,
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		snippets = {
			expand = function(snippet)
				require("luasnip").lsp_expand(snippet)
			end,
			active = function(filter)
				if filter and filter.direction then
					return require("luasnip").jumpable(filter.direction)
				end
				return require("luasnip").in_snippet()
			end,
			jump = function(direction)
				require("luasnip").jump(direction)
			end,
		},
		keymap = {
			preset = "none",
			["<C-j>"] = { "select_next", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
			["<CR>"] = { "accept", "fallback" },
			["<C-h>"] = { "snippet_backward", "fallback" },
			["<C-l>"] = { "snippet_forward", "fallback" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
			["<C-n>"] = { "cancel", "fallback" },
		},
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},
		completion = {
			accept = {
				create_undo_point = true,
			},
			list = {
				max_items = 10,
				cycle = {
					from_top = true,
					from_bottom = true,
				},
				selection = function(ctx)
					local is_math = require("md-latex").is_math
					if ctx.mode == "cmdline" then
						return "manual"
					elseif is_math then
						return "manual"
					end
					return "auto_insert"
				end,
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 100,
				window = {
					border = "rounded",
				},
			},
			menu = {
				border = "rounded",
			},
		},

		sources = {
			default = { "lsp", "path", "luasnip", "buffer", "lazydev" },
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100,
				},
			},
		},
	},
}
