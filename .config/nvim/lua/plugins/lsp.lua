require("mason").setup()

-- Add lsp server
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "pyright" },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Setup lsp completion
require("lspconfig").lua_ls.setup({
	capabilities = capabilities,
})
require("lspconfig").pyright.setup({
	capabilities = capabilities,
})

-- Add linter and formatter
local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.black,
		null_ls.builtins.diagnostics.pylint,
	},
})

-- Add debugger here whenever u can u lazy ass

-- Treesitter highlighting
require("nvim-treesitter.configs").setup({
	ensure_installed = { "markdown", "markdown_inline", "python" },
	highlight = {
		enable = true, -- Enable syntax highlighting
		additional_vim_regex_highlighting = false, -- Disable legacy regex-based highlighting
	},
})
