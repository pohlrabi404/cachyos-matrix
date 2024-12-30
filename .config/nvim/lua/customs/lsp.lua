local M = {}

M.setup = function(event)
	M.event = event
	M.client = vim.lsp.get_client_by_id(M.event.data.client_id)
	M.keymap()
	M.autocmds()
end

M.map = function(keys, func, desc, mode)
	mode = mode or "n"
	vim.keymap.set(mode, keys, func, { buffer = M.event.buf, desc = "LSP: " .. desc })
end

M.keymap = function()
	local builtin = require("telescope.builtin")
	local rename = require("nvchad.lsp.renamer")

	M.map("gd", builtin.lsp_definitions, "[g]o to [d]efinition")
	M.map("gr", builtin.lsp_references, "[g]o to [r]eferences")
	M.map("gI", builtin.lsp_implementations, "[g]o to [I]mplementations")
	M.map("<leader>D", builtin.lsp_type_definitions, "type [D]efinition")

	-- Symbols are variables, functions, etc.
	M.map("<leader>ds", builtin.lsp_document_symbols, "[d]ocument [s]ymbols")

	-- Similar, but over the whole workspace
	M.map("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "[w]orkspace [s]ymbols")
	M.map("<leader>rn", rename, "[r]e[n]ame")
	M.map("<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ctions")
	M.map("gD", vim.lsp.buf.declaration, "[g]oto [D]eclaration")

	-- Inlay hints
	if M.client and M.client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
		M.map("<leader>th", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = M.event.buf }))
		end, "[T]oggle Inlay [H]ints")
	end
end

M.autocmds = function()
	-- Get code signature when typing
	if M.client and M.client.supports_method(vim.lsp.protocol.Methods.textDocument_signatureHelp) then
		local signature_augroup = vim.api.nvim_create_augroup("signature-lsp", { clear = false })
		vim.api.nvim_create_autocmd({ "InsertEnter", "InsertChange" }, {
			buffer = M.event.buf,
			group = signature_augroup,
			callback = vim.lsp.buf.signature_help,
		})
		vim.api.nvim_create_autocmd({ "InsertLeave" }, {
			buffer = M.event.buf,
			group = signature_augroup,
			callback = vim.lsp.buf.clear_references,
		})
		vim.api.nvim_create_autocmd("LspDetach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
			callback = function(event2)
				vim.lsp.buf.clear_references()
				vim.api.nvim_clear_autocmds({ group = "signature_augroup", buffer = event2.buf })
			end,
		})
	end

	-- Get highlight references when cursor hovering
	if M.client and M.client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
		local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			buffer = M.event.buf,
			group = highlight_augroup,
			callback = vim.lsp.buf.document_highlight,
		})

		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
			buffer = M.event.buf,
			group = highlight_augroup,
			callback = vim.lsp.buf.clear_references,
		})
		vim.api.nvim_create_autocmd("LspDetach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
			callback = function(event2)
				vim.lsp.buf.clear_references()
				vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
			end,
		})
	end
end

return M
