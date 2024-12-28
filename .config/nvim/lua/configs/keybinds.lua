local function set(m, k, f, st)
	local settings = { silent = true, noremap = false }
	if st ~= nil then
		for key, value in pairs(st) do
			settings[key] = value
		end
	end
	vim.keymap.set(m, k, f, settings)
end

-- Change scrolling behaviour
set("n", "j", "jzz")
set("n", "k", "kzz")
set("n", "G", "Gzz")
set("n", "<C-d>", "<C-d>zz", { buffer = true })
set("n", "<C-u>", "<C-u>zz", { buffer = true })

-- Default keybinds
set("n", "<Esc>", "<cmd>nohlsearch<CR><Esc>", { noremap = true })
set("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
set("n", ";c", "<cmd>s/\\<./\\u&/g<CR><cmd>nohlsearch<CR>")

