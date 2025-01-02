local M = {}

local client = nil

M.setup = function()
	AutoCmd("LspAttach", {
		group = AutoGroup("lsp-attach", { clear = true }),
		callback = function(event)
			client = vim.lsp.get_client_by_id(event.data.client_id)
			M.highlight(event)
		end,
	})
end

M.highlight = function(event)
	if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
		local highlight_augroup = AutoGroup("kickstart-lsp-highlight", { clear = false })
		AutoCmd({ "CursorHold", "CursorHoldI" }, {
			buffer = event.buf,
			group = highlight_augroup,
			callback = vim.lsp.buf.document_highlight,
		})

		AutoCmd({ "CursorMoved", "CursorMovedI" }, {
			buffer = event.buf,
			group = highlight_augroup,
			callback = vim.lsp.buf.clear_references,
		})
		AutoCmd("LspDetach", {
			group = AutoGroup("kickstart-lsp-detach", { clear = true }),
			callback = function(event2)
				vim.lsp.buf.clear_references()
				vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
			end,
		})
	end
end

return M
