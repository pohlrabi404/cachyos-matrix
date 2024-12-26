-- Check if .requirements.txt exists
if vim.fn.filereadable(".requirements.txt") == 1 and vim.fn.isdirectory(".virtualenv") == 0 then
  local result = vim.fn.system([[
    python3 -m venv .virtualenv/molten
    source .virtualenv/molten/bin/activate
    pip install -r .requirements.txt
    ]])

  -- Check if the command was successful
  if vim.v.shell_error == 0 then
    print("Dependencies installed successfully!")
  else
    print("Error installing dependencies: " .. result)
  end
end

vim.g.molten_image_provider = "image.nvim"

vim.g.molten_wrap_output = true

-- Output as virtual text. Allows outputs to always be shown, works with images, but can
-- be buggy with longer images
vim.g.molten_virt_text_output = true

-- this will make it so the output shows up below the \`\`\` cell delimiter
vim.g.molten_virt_lines_off_by_1 = true

vim.g.molten_tick_rate = 200

vim.keymap.set("n", ";md", ":MoltenDelete<CR>", { desc = "delete Molten cell", silent = true })

-- Quarto
local quarto = require("quarto")
quarto.setup({
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
})
local runner = require("quarto.runner")
vim.keymap.set("n", ";rc", runner.run_cell, { desc = "run cell", silent = true })
vim.keymap.set("n", ";ra", runner.run_above, { desc = "run cell and above", silent = true })
vim.keymap.set("n", ";rA", runner.run_all, { desc = "run all cells", silent = true })

-- Jupytertext
require("jupytext").setup({
	style = "markdown",
	output_extension = "md",
	force_ft = "markdown",
})

-- Treesitter
require("nvim-treesitter.configs").setup({
	textobjects = {
		move = {
			enable = true,
			set_jumps = false, -- you can change this if you want.
			goto_next_start = {
				--- ... other keymaps
				["<C-j>"] = { query = "@code_cell.inner", desc = "next code block" },
			},
			goto_previous_start = {
				--- ... other keymaps
				["<C-k>"] = { query = "@code_cell.inner", desc = "previous code block" },
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

-- Output chunks
-- automatically import output chunks from a jupyter notebook
-- tries to find a kernel that matches the kernel in the jupyter notebook
-- falls back to a kernel that matches the name of the active venv (if any)
local imb = function(e) -- init molten buffer
    vim.schedule(function()
        local kernels = vim.fn.MoltenAvailableKernels()
        local try_kernel_name = function()
            local metadata = vim.json.decode(io.open(e.file, "r"):read("a"))["metadata"]
            return metadata.kernelspec.name
        end
        local ok, kernel_name = pcall(try_kernel_name)
        if not ok or not vim.tbl_contains(kernels, kernel_name) then
            kernel_name = nil
            local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
            if venv ~= nil then
                kernel_name = string.match(venv, "/.+/(.+)")
            end
        end
        if kernel_name ~= nil and vim.tbl_contains(kernels, kernel_name) then
            vim.cmd(("MoltenInit %s"):format(kernel_name))
        end
        vim.cmd("MoltenImportOutput")
    end)
end

-- automatically import output chunks from a jupyter notebook
vim.api.nvim_create_autocmd("BufAdd", {
    pattern = { "*.ipynb" },
    callback = imb,
})

-- we have to do this as well so that we catch files opened like nvim ./hi.ipynb
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "*.ipynb" },
    callback = function(e)
        if vim.api.nvim_get_vvar("vim_did_enter") ~= 1 then
            imb(e)
        end
    end,
})
-- automatically export output chunks to a jupyter notebook on write
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "*.ipynb" },
    callback = function()
        if require("molten.status").initialized() == "Molten" then
            vim.cmd("MoltenExportOutput!")
        end
    end,
})

-- New note book
-- Provide a command to create a blank new Python notebook
-- note: the metadata is needed for Jupytext to understand how to parse the notebook.
-- if you use another language than Python, you should change it in the template.
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
      "display_name": "Python 3",
      "language": "python",
      "name": "python3"
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
    print("Error: Could not open new notebook file for writing.")
  end
end

vim.api.nvim_create_user_command('NewNotebook', function(opts)
  new_notebook(opts.args)
end, {
  nargs = 1,
  complete = 'file'
})
