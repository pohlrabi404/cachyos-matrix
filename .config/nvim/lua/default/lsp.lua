-- ╔════════════════════╗
-- ║ Treesitter Setting ║
-- ╚════════════════════╝
local treesitter = {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
  event = "VeryLazy",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "markdown", "markdown_inline", },
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			modules = {},
			sync_install = true,
			auto_install = true,
			ignore_install = {},
		})
	end,
}
local treesitter_textobjects = {
	"nvim-treesitter/nvim-treesitter-textobjects",
	dependencies = "nvim-treesitter/nvim-treesitter",
	event = "VeryLazy",
}

-- ╔════════════════════╗
-- ║ Completion Setting ║
-- ╚════════════════════╝
local lazydev = {
	"folke/lazydev.nvim",
	opts = {
		library = {
			"nvim-dap-ui",
		},
	},
}

local nvim_cmp = {
	"hrsh7th/nvim-cmp",
	dependencies = { "L3MON4D3/LuaSnip" },
	event = { "InsertEnter", "CmdlineEnter" },
	opts = function(_, opts)
		local snip = require("luasnip")
		local cmp = require("cmp")

		local has_words_before = function()
			unpack = unpack or table.unpack
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end

		opts = {
			snippet = {
				expand = function(args)
					snip.lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Tab>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				["<C-j>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif snip.locally_jumpable(1) then
						snip.jump(1)
					else
						fallback()
					end
				end),
				["<C-k>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif snip.locally_jumpable(-1) then
						snip.jump(-1)
					else
						fallback()
					end
				end),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						if #cmp.get_entries() == 1 then
							cmp.confirm({ select = true })
						else
							cmp.select_next_item()
						end
					elseif snip.locally_jumpable(1) then
						snip.jump(1)
					elseif has_words_before() then
						cmp.complete()
						if #cmp.get_entries() == 1 then
							cmp.confirm({ select = true })
						end
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- For luasnip users.
				{ name = "lazydev", group_index = 0 },
			}, {
				{ name = "buffer" },
			}),
		}
		return opts
	end,
}

local cmp_nvim_lsp = {
	"hrsh7th/cmp-nvim-lsp",
	event = "VeryLazy",
}

-- ╔═════════════════╗
-- ║ Language Server ║
-- ╚═════════════════╝
local mason = {
	"williamboman/mason.nvim",
	event = "VeryLazy",
	opts = {},
}
local mason_lspconfig = {
	"williamboman/mason-lspconfig.nvim",
	event = "UIEnter",
	opts = {
		ensure_installed = { "lua_ls" },
	},
}
local nvim_lspconfig = {
	"neovim/nvim-lspconfig",
	dependencies = mason_lspconfig[1],
	event = "VeryLazy",
	keys = {
		{
			"<leader>cf",
			vim.lsp.buf.format,
			mode = "n",
			desc = "Code Formatting",
		},
		{
			"<leader>ch",
			vim.lsp.buf.hover,
			mode = "n",
			desc = "Hover Over Text",
		},
		{
			"<leader>cd",
			vim.lsp.buf.definition,
			mode = "n",
			desc = "Goto Definition",
		},
		{
			"<leader>ca",
			vim.lsp.buf.code_action,
			mode = "n",
			silent = false,
			desc = "Show Code Actions",
		},
	},
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local config = require("lspconfig")
		config.lua_ls.setup({
			capabilities = capabilities,
		})
		vim.cmd("LspStart")
	end,
}

local null_ls = {
	"nvimtools/none-ls.nvim",
	event = { "BufRead", "VeryLazy" },
	opts = function(_, opts)
		local null_ls = require("null-ls")
		opts.sources = {
			null_ls.builtins.formatting.stylua,
		}
	end,
}

return {
	treesitter,
	treesitter_textobjects,
	nvim_cmp,
	mason,
	null_ls,
	mason_lspconfig,
	null_ls,
	nvim_lspconfig,
	cmp_nvim_lsp,
	lazydev,
}
