local g = vim.g

local function get_current_time_string()
	local now = os.date("*t")
	local datetime_string =
		string.format("%04d%02d%02d%02d%02d%02d", now.year, now.month, now.day, now.hour, now.min, now.sec)
	return datetime_string
end

g.wiki_root = "~/wiki/root"
g.wiki_link_creation = {
	md = {
		link_type = "md",
		url_extension = ".md",
		url_transform = function(x)
			local title = get_current_time_string() .. "-" .. x
			return string.lower(string.gsub(title, "%s+", "-"))
		end,
	},
	_ = {
		link_type = "md",
		url_extension = ".md",
		url_transform = function(x)
			local title = get_current_time_string() .. "-" .. x
			return string.lower(string.gsub(title, "%s+", "-"))
		end,
	},
}

g.wiki_select_method = {
	pages = require("wiki.telescope").pages,
	tags = require("wiki.telescope").tags,
	toc = require("wiki.telescope").toc,
	links = require("wiki.telescope").links,
}

g.wiki_templates = {
	{
		match_re = "index",
		source_filename = "~/wiki/templates/index.md",
	},
	{
		match_func = function()
			return true
		end,
		source_func = function(context)
			local title = ""
			local datetime = ""
			for str in context.name:gmatch("([^-]+)") do
				if datetime == "" then
					datetime = str
				else
					title = title .. " " .. str:gsub("^%l", string.upper)
				end
			end
			local date_string = datetime:sub(1, 8)
			local time_string_part = datetime:sub(9)

			local year = tonumber(date_string:sub(1, 4))
			local month = tonumber(date_string:sub(5, 6))
			local day = tonumber(date_string:sub(7, 8))

			local hour = tonumber(time_string_part:sub(1, 2))
			local minute = tonumber(time_string_part:sub(3, 4))
			local second = tonumber(time_string_part:sub(5, 6))

			local date = string.format("%04d-%02d-%02d", year, month, day)
			local time = string.format("%02d:%02d:%02d", hour, minute, second)
			local template = {
				"---",
				"author: Pohlrabi",
				"date: " .. date,
				"time: " .. time,
				"---",
				"#" .. title,
			}
			vim.api.nvim_buf_set_lines(0, 0, 5, false, template)
		end,
	},
}

-- Add wiki link using selection
local function get_selection()
	local s_row, s_col = unpack(vim.api.nvim_buf_get_mark(0, "<"))
	local e_row, e_col = unpack(vim.api.nvim_buf_get_mark(0, ">"))
	local selection = vim.api.nvim_buf_get_text(0, s_row - 1, s_col, e_row - 1, e_col + 1, {})
	return selection
end

function WikiLinkAddVisual()
	local select = get_selection()
	vim.cmd("WikiLinkAdd")
	vim.api.nvim_input(select[1])
end
vim.keymap.set("v", "<leader>wa", ":lua WikiLinkAddVisual()<CR>")
