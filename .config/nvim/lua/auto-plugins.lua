local function get_lua_file_names(folder_path)
    local lua_file_names = {}
    local cmd = "ls " .. folder_path
    local f = io.popen(cmd, "r")
    for file in f:lines() do
        if string.sub(file, -4) == ".lua" then
            local file_name = string.sub(file, 1, -5)
            table.insert(lua_file_names, file_name)
        end
    end
    f:close()
    return lua_file_names
end
local plugins_path = "$HOME/.config/nvim/lua/installs"
local plugins = get_lua_file_names(plugins_path)
for _, name in ipairs(plugins) do
  require("installs." .. name)
end
