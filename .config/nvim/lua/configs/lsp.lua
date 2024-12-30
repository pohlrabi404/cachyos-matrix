local M = {}

M.lazydev = {
	library = {
		-- Load luvit types when the `vim.uv` word is found
		{ path = "luvit-meta/library", words = { "vim%.uv" } },
	},
}

M.lspconfig = function()
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
		callback = function(event)
			require("customs.lsp").setup(event)
		end,
	})

	-- Change diagnostic symbols in the sign column (gutter)
	if vim.g.have_nerd_font then
		local signs = { ERROR = "", WARN = "", INFO = "", HINT = "" }
		local diagnostic_signs = {}
		for type, icon in pairs(signs) do
			diagnostic_signs[vim.diagnostic.severity[type]] = icon
		end
		vim.diagnostic.config({ signs = { text = diagnostic_signs } })
	end
end

M.masonconfig = function()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
	local servers = {
		lua_ls = {
			settings = {
				Lua = {
					completion = {
						callSnippet = "Replace",
					},
					diagnostics = { disable = { "missing-fields" } },
				},
			},
		},
	}
	local ensure_installed = vim.tbl_keys(servers or {})
	vim.list_extend(ensure_installed, {
		"stylua",
	})

	require("mason").setup()

	require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
	require("mason-lspconfig").setup({
		handlers = {
			function(server_name)
				local server = servers[server_name] or {}
				-- This handles overriding only values explicitly passed
				-- by the server configuration above. Useful when disabling
				-- certain features of an LSP (for example, turning off formatting for ts_ls)
				server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
				require("lspconfig")[server_name].setup(server)
			end,
		},
	})
end

return M
