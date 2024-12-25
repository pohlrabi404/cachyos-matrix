local M = {}
function M.math()
	-- Get the current line
	local current_line = vim.api.nvim_get_current_line()
	local line_number = vim.api.nvim_win_get_cursor(0)[1]

	local math_functions = {
		"sin",
		"cos",
		"tan",
		"asin",
		"acos",
		"atan",
		"sqrt",
		"log",
		"log10",
		"exp",
		"deg",
		"rad",
		"abs",
		"ceil",
		"floor",
	}

	for _, func in ipairs(math_functions) do
		current_line = current_line:gsub(func .. "%(", "math." .. func .. "(")
	end

	current_line = current_line:gsub("pi", "math.pi")
	current_line = current_line:gsub("(%a)e", "%1e")
	current_line = current_line:gsub("(%d)e", "%1e")
	current_line = current_line:gsub("e([^%a]|%d)", "math.exp(1)%1")
	print(current_line)
	local func, err = load("return " .. current_line)
	if func then
		local success, result = pcall(func)
		if success then
			vim.api.nvim_buf_set_lines(0, line_number - 1, line_number, false, { tostring(result) })
		else
			print("Error evaluating")
		end
	else
		print("Invalid expression " .. err)
	end
end

-- Create the command within the plugin
vim.api.nvim_create_user_command("QuickMath", M.math, {})

local function int_to_bin(num)
	if num == 0 then
		return "0"
	end
	local bin = ""
	while num > 0 do
		bin = (num % 2) .. bin
		num = math.floor(num / 2)
	end
	return bin
end
function M.dec_to_bin()
	local current_line = vim.api.nvim_get_current_line()
	local line_number = vim.api.nvim_win_get_cursor(0)[1]
	local int_part = math.floor(current_line)
	local frac_part = current_line - int_part
	local int_bin = int_to_bin(int_part)
	local frac_bin = ""
	while frac_part > 0 and #frac_bin < 10 do
		frac_part = frac_part * 2
		if frac_part >= 1 then
			frac_bin = frac_bin .. "1"
			frac_part = frac_part - 1
		else
			frac_bin = frac_bin .. "0"
		end
	end
	vim.api.nvim_buf_set_lines(0, line_number - 1, line_number, false, { tostring(int_bin .. "." .. frac_bin) })
end

vim.api.nvim_create_user_command("DecToBin", M.dec_to_bin, {})
return M
