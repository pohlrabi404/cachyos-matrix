-- Molten
vim.g.python3_host_prog = vim.fn.expandcmd("~/.virtualenvs/neovim/bin/python3")
vim.g.molten_auto_open_output = true
vim.g.molten_image_provider = "image.nvim"
vim.g.molten_wrap_output = true
vim.g.molten_virt_text_output = true
vim.g.molten_virt_lines_off_by_1 = true

local imolten = {
	"benlubas/molten-nvim",
	version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
	build = {
		[[python3 -m venv ~/.virtualenvs/neovim &&
    source ~/.virtualenvs/neovim/bin/activate &&
    pip install pynvim jupyter_client jupytext nbformat &&
    deactivate]],
		":UpdateRemotePlugins",
	},
	config = function()
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

		vim.api.nvim_create_user_command("NewNotebook", function(opts)
			new_notebook(opts.args)
		end, {
			nargs = 1,
			complete = "file",
		})
	end,
	keys = {
		{
			"<leader>jk",
			function()
				local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
				if venv ~= nil then
					-- in the form of /home/benlubas/.virtualenvs/VENV_NAME
					venv = string.match(venv, "/.+/(.+)")
					vim.cmd(("MoltenInit %s"):format(venv))
				else
					vim.cmd("MoltenInit python3")
				end
			end,
			desc = "Initialize Molten",
			silent = true,
		},
	},
}

-- Image.nvim
local iimage = {
	"3rd/image.nvim",
	event = "VeryLazy",
	opts = {
		backend = "kitty", -- whatever backend you would like to use
		max_width = 100,
		max_height = 12,
		max_height_window_percentage = math.huge,
		max_width_window_percentage = math.huge,
		window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
		window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
	},
}

local iotter = {
	"jmbuhr/otter.nvim",
  event = "VeryLazy",
	opts = {},
}

local iquarto = {
	"quarto-dev/quarto-nvim",
	ft = { "markdown", "quarto" },
	opts = {
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
			hover = "<leader>ch",
			definition = "<leader>cd",
			rename = "<leader>rn",
			references = "<leader>cr",
			format = "<leader>cf",
		},
		codeRunner = {
			enabled = true,
			default_method = "molten",
		},
	},
}

local ijupytext = {
	"GCBallesteros/jupytext.nvim",
	opts = function(_, opts)
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
		opts = {
			style = "markdown",
			output_extension = "md",
			force_ft = "markdown",
		}
		return opts
	end,
}

return {
	imolten,
	iimage,
	iquarto,
	iotter,
	ijupytext,
}
