local M = {}
function M.math()
  -- Get the current line 
  local current_line = vim.api.nvim_get_current_line()
  local line_number = vim.api.nvim_win_get_cursor(0)[1]

  local math_functions = {"sin", "cos", "tan", "asin", "acos", "atan", "sqrt", "log", "log10", "exp", "deg", "rad", "abs", "ceil", "floor"}

  for _, func in ipairs(math_functions) do
    current_line = current_line:gsub(func .. "%(", "math." .. func .. "(")
  end

  current_line = current_line:gsub("pi", "math.pi")
  current_line = current_line:gsub("(.)e(.)", function(a, b)
    if (a == "" or a:match("[^%w]")) and (b == "" or b:match("[^%a]")) then
      return a .. "math.exp(1)" .. b
    else
      return a .. "e" .. b
    end
  end)
  local func, err = load("return " .. current_line)
  if func then
    local success, result = pcall(func)
    if success then
      vim.api.nvim_buf_set_lines(0, line_number - 1, line_number, false, {tostring(result)})
    else
      print("Error evaluating")
    end
  else
    print("Invalid expression " .. err)
  end
end
-- Create the command within the plugin 
vim.api.nvim_create_user_command('QuickMath', M.math, {})
return M
