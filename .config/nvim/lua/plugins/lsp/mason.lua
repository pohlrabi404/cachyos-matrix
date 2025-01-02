local M = {}

M.config = function()
	local servers = require("plugins.lsp.configs").servers
	local ensure_installed = vim.tbl_keys(servers or {})

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	local dc = require("cmp_nvim_lsp").default_capabilities()

	capabilities = vim.tbl_deep_extend("force", capabilities, dc)

	require("mason").setup()
	require("mason-tool-installer").setup({
		ensure_installed = ensure_installed,
	})
	require("mason-lspconfig").setup({
		handlers = {
			function(server_name)
				local server = servers[server_name] or {}
				server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
				require("lspconfig")[server_name].setup(server)
			end,
		},
	})

	--- Diagnostic
	if vim.g.have_nerd_font then
		local signs = { ERROR = "", WARN = "", INFO = "", HINT = "" }
		local diagnostic_signs = {}
		for type, icon in pairs(signs) do
			diagnostic_signs[vim.diagnostic.severity[type]] = icon
		end
		vim.diagnostic.config({ signs = { text = diagnostic_signs } })
	end

	require("plugins.lsp.events").setup()
end

return M
