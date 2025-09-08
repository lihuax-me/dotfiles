-------------------------------------
--- Keymaps for Article Editing   ---
-------------------------------------
-- Helper to set keymaps concisely
local function map(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

map("n", "<leader>aU", "<cmd>set fileformat=unix<CR>", "Set file format to Unix")
map("v", "<leader>ae", ":SwitchText<CR>", "Switch text format to English style")
map("v", "<leader>as", ":AddSpacing<CR>", "Insert whitespace between CJK and half-width characters")
map("v", "<leader>aS", ":DelSpacing<CR>", "Delete whitespace between CJK and half-width characters")

map("v", "<leader>an", ":ChangeNum<CR>", "Convert circled numbers to Arabic")
map("v", "<leader>ap", ":TogglePeriod<CR>", "Toggle English period to Chinese")
map("n", "<leader>al", ":echo expand('%:p')<CR>", "Print current file path")

-------------------------------------
--- Text Formatting Functions     ---
-------------------------------------

--- Replace Chinese punctuation with English punctuation,
--- and clean up extra spaces between characters.
local function switch_text_in_visual_mode()
	local replacements = {
		{ "（", "(" },
		{ "）", ")" },
		{ "( ", "(" },
		{ ") ", ")" },
		{ " (", "(" },
		{ " )", ")" },
		{ "， ", "，" },
		{ "，", ", " },
		{ "“", '"' },
		{ "”", '"' },
		{ "‘", "'" },
		{ "’", "'" },
		{ "： ", "：" },
		{ "：", ": " },
		{ "；", ";" },
		{ "。 ", "。" },
	}

	for _, pair in ipairs(replacements) do
		vim.cmd(string.format("silent! '<,'>s/%s/%s/g", pair[1], pair[2]))
	end
end

local function del_spacing()
	local patterns = {
		[[\(\%([^\x00-\xff]\)\)\zs\s\+\ze\%([a-zA-Z]\)]], -- Chinese ↔ English
		[[\(\%([a-zA-Z]\)\)\zs\s\+\ze\%([^\x00-\xff]\)]], -- English ↔ Chinese
		[[\(\%([^\x00-\xff]\)\)\zs\s\+\ze\%([^\x00-\xff]\)]], -- Chinese ↔ Chinese
		[[\(\%([^\x00-\xff]\)\)\zs\s\+\ze\%([0-9]\)]], -- Chinese ↔ Number
		[[\(\%([0-9]\)\)\zs\s\+\ze\%([^\x00-\xff]\)]], -- Number ↔ Chinese
		[[\s\+$]], -- Trailing spaces
	}

	for _, pattern in ipairs(patterns) do
		vim.cmd(string.format("silent! '<,'>s/%s//g", pattern))
	end
end

local function add_spacing()
	-- 使用视觉选择范围
	local patterns = {
		-- 中文后跟英文/数字/希腊字母，插入空格
		[[\([一-龥]\)\([a-zA-Z0-9α-ωΑ-Ωβ]*[a-zA-Zα-ωΑ-Ωβ][a-zA-Z0-9α-ωΑ-Ωβ]*\)]],
		-- 英文/数字/希腊字母后跟中文，插入空格
		[[\([a-zA-Z0-9α-ωΑ-Ωβ]*[a-zA-Zα-ωΑ-Ωβ][a-zA-Z0-9α-ωΑ-Ωβ]*\)\([一-龥]\)]],
	}

	for _, pattern in ipairs(patterns) do
		vim.cmd(string.format("silent! '<,'>s/%s/\\1 \\2/g", pattern))
	end
end

vim.api.nvim_create_user_command("SwitchText", switch_text_in_visual_mode, { range = true })
vim.api.nvim_create_user_command("DelSpacing", del_spacing, { range = true })
vim.api.nvim_create_user_command("AddSpacing", add_spacing, { range = true })

-------------------------------------
--- Number Conversion             ---
-------------------------------------

--- Convert circled numbers to Arabic numbers.
local function ChangeNum()
	local num_map = {
		["①"] = "1. ",
		["②"] = "2. ",
		["③"] = "3. ",
		["④"] = "4. ",
		["⑤"] = "5. ",
		["⑥"] = "6. ",
		["⑦"] = "7. ",
		["⑧"] = "8. ",
		["⑨"] = "9. ",
		["⑩"] = "10. ",
	}

	for symbol, replacement in pairs(num_map) do
		vim.cmd(string.format("silent! '<,'>s/^%s/%s/g", symbol, replacement))
		vim.cmd(string.format("silent! '<,'>s/%s/\\r%s/g", symbol, replacement))
	end
end

vim.api.nvim_create_user_command("ChangeNum", ChangeNum, { range = true })

-------------------------------------
--- Period Toggle                  ---
-------------------------------------

--- Toggle English period (.) to Chinese period (。) in selected range.
local function toggle_period()
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")
	local start_row, start_col = start_pos[2], start_pos[3]
	local end_row, end_col = end_pos[2], end_pos[3]
	local lines = vim.api.nvim_buf_get_lines(0, start_row - 1, end_row, false)

	for i, line in ipairs(lines) do
		if i == 1 then
			line = line:sub(1, start_col - 1) .. line:sub(start_col):gsub("%.", "。")
		elseif i == #lines then
			if end_col == #line then
				line = line:sub(1, end_col):gsub("%.", "。")
			else
				line = line:sub(1, end_col):gsub("%.", "。") .. line:sub(end_col + 1)
			end
		else
			line = line:gsub("%.", "。")
		end
		lines[i] = line
	end

	vim.api.nvim_buf_set_lines(0, start_row - 1, end_row, false, lines)
end

vim.api.nvim_create_user_command("TogglePeriod", toggle_period, { range = true })

-----------------------
-----------------------

local function mark_highlight()
	vim.cmd("silent! %s/^==\\([^=][^=]*\\)==/<mark>\\1<\\/mark>/g")
	vim.cmd("silent! %s/\\s==\\([^=][^=]*\\)==/ <mark>\\1<\\/mark>/g")
	vim.cmd("silent! %s/\\([[:punct:]]\\)==\\([^=][^=]*\\)==/\\1<mark>\\2<\\/mark>/g")
	vim.cmd("silent! %s/==\\([^=][^=]*\\)==\\([[:punct:]]\\)/<mark>\\1<\\/mark>\\2/g")
	vim.cmd("silent! %s/==\\([^=][^=]*\\)==\\s/<mark>\\1<\\/mark> /g")
end

vim.api.nvim_create_user_command("ReplaceMarkers", mark_highlight, {})
-- vim.keymap.set("n", "<leader>rm", replace_markers, { desc = "Replace == markers" })
