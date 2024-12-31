local M = {}

M.setup = function(opts_func)
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
		callback = function(event)
			M.event = event
			M.client = vim.lsp.get_client_by_id(M.event.data.client_id)
			M.gen_available_keys()
			M.autocmds()
			M.diagnostic()
			M.set_keymap(opts_func)
		end,
	})
end

M.funcs = {}

M.gen_available_keys = function()
	local builtin = require("telescope.builtin")
	local rename = require("nvchad.lsp.renamer")

	M.funcs = {
		definitions = builtin.lsp_definitions,
		references = builtin.lsp_references,
		implementations = builtin.lsp_implementations,
		type_definitions = builtin.lsp_type_definitions,
		document_symbols = builtin.lsp_document_symbols,
		workspace_symbols = builtin.lsp_workspace_symbols,
		dynamic_workspace_symbols = builtin.lsp_dynamic_workspace_symbols,
		rename = rename,
		code_action = vim.lsp.buf.code_action,
		declaration = vim.lsp.buf.declaration,
	}

	if M.client and M.client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
		M.funcs.inlay_hint = function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = M.event.buf }))
		end
	end
end

M.set_keymap = function(opts_func)
	for _, key in ipairs(opts_func()) do
		M.map(unpack(key))
	end
end

-- Inner functions
M.diagnostic = function()
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

M.map = function(mode, keys, func, desc)
	mode = mode or "n"
	vim.keymap.set(mode, keys, func, { buffer = M.event.buf, desc = "LSP: " .. desc })
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
