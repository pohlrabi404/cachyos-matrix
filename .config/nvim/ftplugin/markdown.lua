local profile = os.getenv("NVIM_PROFILE") or "default"
if profile == "jupyter" then
  require("quarto").activate()
end
