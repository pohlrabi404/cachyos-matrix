local M = {}

M.opts = function(_, opts)
  opts = opts or {}
  local custom_opts = {
    formatters_by_ft = {
      lua = {"stylua"},
    },
    format_on_save = {
      timeout_ms = 500
    },
  }
  return vim.tbl_deep_extend("force", opts, custom_opts)
end

return M
