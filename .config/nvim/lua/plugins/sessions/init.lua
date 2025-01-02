return {
	"rmagatti/auto-session",
	event = "User FilePost",
	cmd = "SessionRestore",
	keys = require("plugins.sessions.configs").mappings,
	opts = require("plugins.sessions.configs").opts,
}
