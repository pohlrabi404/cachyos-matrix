local mini = {
	"echasnovski/mini.nvim",
	version = false,
  event = "VeryLazy",
	config = function()
		require("mini.ai").setup()
		require("mini.ai").setup()
		require("mini.icons").setup()
		require("mini.jump2d").setup({
			mappings = {
				start_jumping = ";;",
			},
		})
		require("mini.notify").setup()
		require("mini.pairs").setup()
		require("mini.splitjoin").setup()
		require("mini.surround").setup()
	end,
}
local sessions = {
  "echasnovski/mini.sessions",
  event = "VimEnter",
  opts = {
    autoread = true,
  }
}
return { mini, sessions }
