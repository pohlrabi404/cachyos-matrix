vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
	local repo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(lazypath)

local colors = {
	base00 = "#000000", -- Background
	base01 = "#2a2a2a", -- Lighter background (status bars, line numbers)
	base02 = "#555555", -- Selection background
	base03 = "#808080", -- Comments, invisibles
	base04 = "#a0a0a0", -- Dark foreground (status bars)
	base05 = "#c0c0c0", -- Default foreground
	base06 = "#e0e0e0", -- Light foreground (rarely used)
	base07 = "#ffffff", -- Light background (rarely used)
	base08 = "#ff5555", -- Variables, XML tags, Markup link text
	base09 = "#ff9955", -- Integers, Boolean, Constants, XML attributes
	base0A = "#ffff55", -- Classes, Markup bold
	base0B = "#55ff55", -- Strings, Inherited class, Markup code
	base0C = "#55ffff", -- Support, Regular expressions, Escape characters
	base0D = "#5555ff", -- Functions, Methods, Attribute IDs
	base0E = "#ff55ff", -- Keywords, Storage, Selector
	base0F = "#ff99ff", -- Deprecated, Opening/Closing embedded language tags
}

-- Apply the colorscheme to Neovim
vim.g.base16_colorspace = 256
vim.g.base16_background = "dark"

for k, v in pairs(colors) do
	vim.api.nvim_set_hl(0, k, { fg = v, bg = colors.base00 })
end

-- Example syntax highlighting
vim.api.nvim_set_hl(0, "Normal", { fg = colors.base05, bg = colors.base00 })
vim.api.nvim_set_hl(0, "Comment", { fg = colors.base03, italic = true })
vim.api.nvim_set_hl(0, "Constant", { fg = colors.base09 })
vim.api.nvim_set_hl(0, "String", { fg = colors.base0B })
vim.api.nvim_set_hl(0, "Identifier", { fg = colors.base08 })
vim.api.nvim_set_hl(0, "Function", { fg = colors.base0D })
vim.api.nvim_set_hl(0, "Statement", { fg = colors.base0E })
vim.api.nvim_set_hl(0, "Keyword", { fg = colors.base0E })
vim.api.nvim_set_hl(0, "Type", { fg = colors.base0A })
vim.api.nvim_set_hl(0, "Special", { fg = colors.base0C })
vim.api.nvim_set_hl(0, "Error", { fg = colors.base08, bg = colors.base00 })
vim.api.nvim_set_hl(0, "Todo", { fg = colors.base0A, bg = colors.base00, bold = true })

local lazy_config = require("configs.lazy")

-- load plugins
require("lazy").setup({
	{ import = "plugins" },
}, lazy_config)

require("options")

vim.schedule(function()
	require("mappings")
end)
