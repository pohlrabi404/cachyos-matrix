require("mason").setup()

-- Add lsp server
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls" },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Setup lsp completion
require("lspconfig").lua_ls.setup({
  capabilities = capabilities,
})

-- Add linter and formatter
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
  }
})

-- Add debugger here whenever u can u lazy ass
