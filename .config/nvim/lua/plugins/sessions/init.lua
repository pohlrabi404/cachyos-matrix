return {
	"rmagatti/auto-session",
	event = "User FilePost",
	cmd = "SessionRestore",
	opts = require("plugins.sessions.configs").opts,
}
