local o = vim.opt

-- Color
o.termguicolors = true

-- Relative number
o.relativenumber = true

-- Smart case
o.ignorecase = true
o.smartcase = true
o.incsearch = true
o.hlsearch = true

-- Tab
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true

-- Line wrap
o.wrap = true
o.breakindent = true
o.textwidth = 80
o.linebreak = true

-- Cursor
o.cursorline = true

-- Use system clipboard
o.clipboard = "unnamedplus"

-- Indent
o.smartindent = true
o.autoindent = true

-- Concealing format
o.conceallevel = 2

-- Hide ~
vim.cmd([[ highlight NonText guifg=bg ]])
