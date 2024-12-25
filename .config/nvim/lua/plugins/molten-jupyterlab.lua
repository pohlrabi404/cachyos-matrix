require("image").setup({

	integrations = {}, -- do whatever you want with image.nvim's integrations
	max_width = 100, -- tweak to preference
	max_height = 12, -- ^
	max_height_window_percentage = math.huge, -- this is necessary for a good experience
	max_width_window_percentage = math.huge,
	window_overlap_clear_enabled = true,
	window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
})

require("quarto").setup({
	lspFeatures = {
		-- NOTE: put whatever languages you want here:
		languages = { "python" },
		chunks = "all",
		diagnostics = {
			enabled = true,
			triggers = { "BufWritePost" },
		},
		completion = {
			enabled = true,
		},
		formatting = {
			enabled = true,
		},
	},
	keymap = {
		-- NOTE: setup your own keymaps:
		hover = "H",
		definition = "gd",
		rename = "<leader>rn",
		references = "gr",
		format = "<leader>gf",
	},
	codeRunner = {
		enabled = true,
		default_method = "molten",
	},
	ft = { "quarto", "markdown" },
})

require("jupytext").setup({
	style = "markdown",
	output_extension = "md",
	force_ft = "markdown",
})

require("nvim-treesitter.configs").setup({
	-- ... other ts config
	textobjects = {
		move = {
			enable = true,
			set_jumps = false, -- you can change this if you want.
			goto_next_start = {
				--- ... other keymaps
				["<c-j>"] = { query = "@code_cell.inner", desc = "next code block" },
			},
			goto_previous_start = {
				--- ... other keymaps
				["<c-k>"] = { query = "@code_cell.inner", desc = "previous code block" },
			},
		},
		select = {
			enable = true,
			lookahead = true, -- you can change this if you want
			keymaps = {
				--- ... other keymaps
				["ib"] = { query = "@code_cell.inner", desc = "in block" },
				["ab"] = { query = "@code_cell.outer", desc = "around block" },
			},
		},
	},
})

-- function to check if a directory exists
local function directory_exists(path)
	return vim.fn.isdirectory(path) == 1
end

-- function to load all lua files in a directory
local function load_lua_files_from_dir(dir)
	local lua_files = vim.fn.glob(dir .. "/*.lua", false, true)
	for _, file in ipairs(lua_files) do
		dofile(file)
	end
end

-- function to load local config if .nvim-local exists
local function load_local_config()
	local local_config_dir = vim.fn.getcwd() .. "/.nvim-local"
	if directory_exists(local_config_dir) then
		load_lua_files_from_dir(local_config_dir)
	end
end

-- load local config when entering a new directory
vim.api.nvim_create_autocmd("dirchanged", {
	pattern = "*",
	callback = function()
		load_local_config()
	end,
	desc = "load all local lua files if .nvim-local exists",
})

-- load local config immediately if neovim is opened in a directory with .nvim-local
load_local_config()

-- image.nvim
vim.g.molten_image_provider = "image.nvim"

-- optional, i like wrapping. works for virt text and the output window
vim.g.molten_wrap_output = true

-- output as virtual text. allows outputs to always be shown, works with images, but can
-- be buggy with longer images
vim.g.molten_virt_text_output = true

-- this will make it so the output shows up below the \`\`\` cell delimiter
vim.g.molten_virt_lines_off_by_1 = true

vim.keymap.set("n", "<leader>oh", ":moltenhideoutput<cr>", { desc = "close output window", silent = true })
vim.keymap.set("n", "<leader>md", ":moltendelete<cr>", { desc = "delete molten cell", silent = true })

-- if you work with html outputs:
vim.keymap.set("n", "<leader>mx", ":moltenopeninbrowser<cr>", { desc = "open output in browser", silent = true })

local runner = require("quarto.runner")
vim.keymap.set("n", ";rc", runner.run_cell, { desc = "run cell", silent = true })
vim.keymap.set("n", ";ra", runner.run_above, { desc = "run cell and above", silent = true })
vim.keymap.set("n", ";ra", runner.run_all, { desc = "run all cells", silent = true })
vim.keymap.set("n", ";nn", function()
	-- insert the python code block
	vim.api.nvim_put({ "```python", "", "```" }, "l", true, true)
	-- move the cursor to the middle line
	vim.api.nvim_win_set_cursor(0, { vim.api.nvim_win_get_cursor(0)[1] - 1, 0 })
end, { silent = true, noremap = true })

-- automatically import output chunks from a jupyter notebook
-- tries to find a kernel that matches the kernel in the jupyter notebook
-- falls back to a kernel that matches the name of the active venv (if any)
local imb = function(e) -- init molten buffer
	vim.schedule(function()
		local kernels = vim.fn.moltenavailablekernels()
		local try_kernel_name = function()
			local metadata = vim.json.decode(io.open(e.file, "r"):read("a"))["metadata"]
			return metadata.kernelspec.name
		end
		local ok, kernel_name = pcall(try_kernel_name)
		if not ok or not vim.tbl_contains(kernels, kernel_name) then
			kernel_name = nil
			local venv = os.getenv("virtual_env") or os.getenv("conda_prefix")
			if venv ~= nil then
				kernel_name = string.match(venv, "/.+/(.+)")
			end
		end
		if kernel_name ~= nil and vim.tbl_contains(kernels, kernel_name) then
			vim.cmd(("molteninit %s"):format(kernel_name))
		end
		vim.cmd("moltenimportoutput")
	end)
end

-- automatically import output chunks from a jupyter notebook
vim.api.nvim_create_autocmd("bufadd", {
	pattern = { "*.ipynb" },
	callback = imb,
})

-- we have to do this as well so that we catch files opened like nvim ./hi.ipynb
vim.api.nvim_create_autocmd("bufenter", {
	pattern = { "*.ipynb" },
	callback = function(e)
		if vim.api.nvim_get_vvar("vim_did_enter") ~= 1 then
			imb(e)
		end
	end,
})

-- automatically export output chunks to a jupyter notebook on write
vim.api.nvim_create_autocmd("bufwritepost", {
	pattern = { "*.ipynb" },
	callback = function()
		if require("molten.status").initialized() == "molten" then
			vim.cmd("moltenexportoutput!")
		end
	end,
})

-- provide a command to create a blank new python notebook
-- note: the metadata is needed for jupytext to understand how to parse the notebook.
-- if you use another language than python, you should change it in the template.
local default_notebook = [[
  {
    "cells": [
     {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        ""
      ]
     }
    ],
    "metadata": {
     "kernelspec": {
      "display_name": "python 3",
      "language": "python",
      "name": "python"
     },
     "language_info": {
      "codemirror_mode": {
        "name": "ipython"
      },
      "file_extension": ".py",
      "mimetype": "text/x-python",
      "name": "python",
      "nbconvert_exporter": "python",
      "pygments_lexer": "ipython3"
     }
    },
    "nbformat": 4,
    "nbformat_minor": 5
  }
]]

local function new_notebook(filename)
	local path = filename .. ".ipynb"
	local file = io.open(path, "w")
	if file then
		file:write(default_notebook)
		file:close()
		vim.cmd("edit " .. path)
	else
		print("error: could not open new notebook file for writing.")
	end
end

vim.api.nvim_create_user_command("newnotebook", function(opts)
	new_notebook(opts.args)
end, {
	nargs = 1,
	complete = "file",
})
