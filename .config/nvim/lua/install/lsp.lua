-- ╔════════════════════╗
-- ║ Treesitter Setting ║
-- ╚════════════════════╝
local treesitter = {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "latex", "markdown", "markdown_inline", "python", "html" },
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
		})
	end,
}
local treesitter_textobjects = {
	"nvim-treesitter/nvim-treesitter-textobjects",
	after = "nvim-treesitter",
	requires = "nvim-treesitter/nvim-treesitter",
}

-- ╔════════════════════╗
-- ║ Completion Setting ║
-- ╚════════════════════╝
local nvim_cmp = {
	"hrsh7th/nvim-cmp",
	dependencies = { "L3MON4D3/LuaSnip" },
  lazy = false,
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
        ["<C-j>"] = cmp.mapping(function (fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif snip.locally_jumpable(1) then
            snip.jump(1)
          else
            fallback()
          end
        end),
        ["<C-k>"] = cmp.mapping(function (fallback)
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
			}, {
				{ name = "buffer" },
			}),
		}
    return opts
	end,
}
local cmp_nvim_lsp = {
	"hrsh7th/cmp-nvim-lsp",
}

-- ╔═════════════════╗
-- ║ Language Server ║
-- ╚═════════════════╝
local mason = {
	"williamboman/mason.nvim",
	opts = {},
}
local mason_lspconfig = {
	"williamboman/mason-lspconfig.nvim",
	opts = {
		ensure_installed = { "lua_ls", "pyright" },
	},
}
local nvim_lspconfig = {
	"neovim/nvim-lspconfig",
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local config = require("lspconfig")
		config.lua_ls.setup({
			capabilities = capabilities,
		})
		config.pyright.setup({
			capabilities = capabilities,
			setting = {
				python = {
					analysis = {
						typeCheckingMode = "off",
						diagnosticSeverityOverrides = {
							reportUnusedExpression = "none",
						},
					},
				},
			},
		})
	end,
}

local null_ls = {
	"nvimtools/none-ls.nvim",
	opts = function(_, opts)
		local null_ls = require("null-ls")
		opts.sources = {
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.black,
			null_ls.builtins.diagnostics.pylint,
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
}