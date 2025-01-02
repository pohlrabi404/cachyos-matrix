local opts = require("plugins.gits.configs").opts
return {
	"lewis6991/gitsigns.nvim",
	event = "User FilePost",
	opts = opts,
}
