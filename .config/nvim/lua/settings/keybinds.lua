local function set(m, k, f, st)
	local settings = { silent = true, noremap = false }
	if st ~= nil then
		for key, value in pairs(st) do
			settings[key] = value
		end
	end
	vim.keymap.set(m, k, f, settings)
end

-- Default keybinds
set("n", "<Esc>", "<cmd>nohlsearch<CR><Esc>", { noremap = true })
set("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
set("n", ";c", "<cmd>s/\\<./\\u&/g<CR><cmd>nohlsearch<CR>")

-- Telescope
set("n", "<leader>ff", "<cmd>Telescope file_browser path=%:p:h select_buffer=false<CR>")
set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
set("n", "<leader>fb", "<cmd>lua TelescopeBuffer()<CR>")

-- Obsidian
set("n", ";b", "<cmd>ObsidianBacklinks<CR>")
set("n", ";n", "<cmd>ObsidianNew<CR>")
set("n", ";o", "<cmd>ObsidianOpen<CR>")
set("n", ";s", "<cmd>ObsidianSearch<CR>")
set("n", ";i", "<cmd>ObsidianPasteImg<CR>")
set("n", ";f", "<cmd>ObsidianFollowLink<CR>")
set("v", ";l", function()
	vim.api.nvim_input("sa;%%i<Tab>")
	require("cmp").complete()
end, { noremap = true })

-- Lsp
set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { silent = false })
set("n", "gd", vim.lsp.buf.definition)
set("n", "H", vim.lsp.buf.hover)
set("n", "gf", vim.lsp.buf.format)
