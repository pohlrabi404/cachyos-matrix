local M = {}

M.cmp = function()
	local cmp = require("cmp")
	local luasnip = require("luasnip")
	luasnip.config.setup({})

	cmp.setup({
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		completions = { completeopt = "menu,menuone,noinsert" },
		mapping = cmp.mapping.preset.insert({
			["<C-j>"] = cmp.mapping.select_next_item(),
			["<C-k>"] = cmp.mapping.select_prev_item(),
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<CR>"] = cmp.mapping.confirm({ select = true }),

			["<C-l>"] = cmp.mapping(function()
				if luasnip.expand_or_locally_jumpable() then
					luasnip.expand_or_jump()
				end
			end, { "i", "s" }),
			["<C-h>"] = cmp.mapping(function()
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				end
			end, { "i", "s" }),
		}),
		sources = {
			{
				name = "lazydev",
				group_index = 0,
			},
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "path" },
		},
	})
end

return M