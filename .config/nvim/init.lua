-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = ";"

vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"

AutoCmd = vim.api.nvim_create_autocmd
AutoGroup = vim.api.nvim_create_augroup
ExeAutoCmd = vim.api.nvim_exec_autocmds

local lazy_config = require("plugins.lazy.configs")
require("lazy").setup({
	{ import = "plugins" },
}, lazy_config)

dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require("options")
require("autocmds")

vim.schedule(function()
	require("luasnip").config.setup({ enable_autosnippets = true })
	require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets" })
end)

vim.schedule(function()
	require("mappings")
end)
