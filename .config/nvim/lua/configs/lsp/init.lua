local lsp = require("configs.lsp.lspconfig")
local M = {}

M.lspconfig = function()
	lsp.setup(M.lsp_keymap)
end

M.masonconfig = function()
	local mason = require("configs.lsp.mason")
	mason.setup(M.mason_servers)
end

-- Setup servers
M.mason_servers = function()
	return {
		lua_ls = {
			settings = {
				Lua = {
					completion = {
						callSnippet = "Replace",
					},
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							vim.fn.expand("$VIMRUNTIME/lua"),
							vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
							vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
							"${3rd}/luv/library",
						},
						maxPreload = 100000,
						preloadFileSize = 10000,
					},
					runtime = {
						version = "LuaJIT",
					},
				},
			},
		},
		"stylua",
		"pyright",
		"pylint",
	}
end

M.lsp_keymap = function()
	return {
		{ "n", "gd", lsp.funcs.definitions, "[g]o to [d]efinition" },
		{ "n", "gr", lsp.funcs.references, "[g]o to [r]eferences" },
		{ "n", "gI", lsp.funcs.implementations, "[g]o to [I]mplementations" },
		{ "n", "<leader>D", lsp.funcs.type_definitions, "type [D]efinition" },
		{ "n", "<leader>ds", lsp.funcs.document_symbols, "[d]ocument [s]ymbols" },
		{ "n", "<leader>ws", lsp.funcs.workspace_symbols, "[w]orkspace [s]ymbols" },
		{ "n", "<leader>rn", lsp.funcs.rename, "[r]e[n]ame" },
		{ "n", "<leader>ca", lsp.funcs.code_action, "[c]ode [a]ctions" },
		{ "n", "gD", lsp.funcs.declaration, "[g]oto [D]eclaration" },

		-- Inlay hints
		{ "n", "<leader>th", lsp.funcs.inlay_hint, "[t]oggle inlay [h]ints" },
	}
end

return M
