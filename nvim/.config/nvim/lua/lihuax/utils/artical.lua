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

map("v", "<leader>ab", ":TextBf<CR>", "Bold selected text (**)")
map("v", "<leader>ai", ":TextIt<CR>", "Underline selected text (__)")
map("v", "<leader>ah", ":TextHighlight<CR>", "Highlight selected text (==)")
map("v", "<leader>au", ":TextHtmlUnderline<CR>", "Underline selected text (<u></u>)")
map("v", "<leader>axb", ":TextBfRemove<CR>", "Remove bold markers (**) from selected text")
map("v", "<leader>axi", ":TextItRemove<CR>", "Remove underline markers (__) from selected text")
map("v", "<leader>axh", ":TextHighlightRemove<CR>", "Remove highlight markers (==) from selected text")
map("v", "<leader>axu", ":TextHtmlUnderlineRemove<CR>", "Remove underline markers (<u></u>) from selected text")

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

function add_spacing()
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
--- Surround Insert Utility       ---
-------------------------------------

--- Insert left and right markers around selected text.
local function surround_insert(left, right)
	local end_row, end_col = vim.fn.getpos("'>")[2], vim.fn.getpos("'>")[3]
	local start_row, start_col = vim.fn.getpos("'<")[2], vim.fn.getpos("'<")[3]
	local lines = vim.fn.getline(start_row, end_row)
	if #lines == 0 then
		return
	end

	lines[#lines] = lines[#lines]:sub(1, end_col) .. right .. lines[#lines]:sub(end_col + 1)
	lines[1] = lines[1]:sub(1, start_col - 1) .. left .. lines[1]:sub(start_col)
	vim.fn.setline(start_row, lines)
end

--- Convenience: insert same marker on both sides.
local function surround_insert_same(marker)
	surround_insert(marker, marker)
end

vim.api.nvim_create_user_command("TextBf", function()
	surround_insert_same("**")
end, { range = true })
vim.api.nvim_create_user_command("TextIt", function()
	surround_insert_same("__")
end, { range = true })
vim.api.nvim_create_user_command("TextHighlight", function()
	surround_insert_same("==")
end, { range = true })
vim.api.nvim_create_user_command("TextHtmlUnderline", function()
	surround_insert("<u>", "</u>")
end, { range = true })

-------------------------------------
--- Surround Remove Utility       ---
-------------------------------------

--- Remove surrounding markers from selected text.
local function surround_remove(left, right)
	local start_row, start_col = vim.fn.getpos("'<")[2], vim.fn.getpos("'<")[3]
	local end_row, end_col = vim.fn.getpos("'>")[2], vim.fn.getpos("'>")[3]

	-- Check if selection is valid
	if start_row ~= end_row then
		vim.api.nvim_err_writeln("Error: Cannot remove markers across multiple lines")
		return
	end

	local line = vim.fn.getline(start_row)
	local left_len = #left
	local right_len = #right

	-- Case 1: Check if markers are outside the selection
	local outer_left_start = start_col - left_len
	local outer_right_end = end_col + right_len
	if outer_left_start >= 1 and outer_right_end <= #line then
		local outer_left = line:sub(outer_left_start, start_col - 1)
		local outer_right = line:sub(end_col + 1, outer_right_end)

		if outer_left == left and outer_right == right then
			-- delete outer markers
			local new_line = line:sub(1, outer_left_start - 1)
				.. line:sub(start_col, end_col)
				.. line:sub(outer_right_end + 1)
			vim.fn.setline(start_row, new_line)
			return
		end
	end

	-- Case 2: Check if markers are inside the selection
	local inner_left_end = start_col + left_len - 1
	local inner_right_start = end_col - right_len + 1
	if inner_left_end <= #line and inner_right_start >= 1 then
		local inner_left = line:sub(start_col, inner_left_end)
		local inner_right = line:sub(inner_right_start, end_col)

		if inner_left == left and inner_right == right then
			-- delete inner markers
			local new_line = line:sub(1, start_col - 1)
				.. line:sub(inner_left_end + 1, inner_right_start - 1)
				.. line:sub(end_col + 1)
			vim.fn.setline(start_row, new_line)
			return
		end
	end

	-- No matching markers found
	vim.api.nvim_err_writeln("Error: No matching markers found around selection")
end

--- Remove same marker from both sides.
local function surround_remove_same(marker)
	surround_remove(marker, marker)
end

vim.api.nvim_create_user_command("TextBfRemove", function()
	surround_remove_same("**")
end, { range = true })
vim.api.nvim_create_user_command("TextItRemove", function()
	surround_remove_same("__")
end, { range = true })
vim.api.nvim_create_user_command("TextHighlightRemove", function()
	surround_remove_same("==")
end, { range = true })
vim.api.nvim_create_user_command("TextHtmlUnderlineRemove", function()
	surround_remove("<u>", "</u>")
end, { range = true })

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

function mark_highlight()
	vim.cmd("silent! %s/^==\\([^=][^=]*\\)==/<mark>\\1<\\/mark>/g")
	vim.cmd("silent! %s/\\s==\\([^=][^=]*\\)==/ <mark>\\1<\\/mark>/g")
	vim.cmd("silent! %s/\\([[:punct:]]\\)==\\([^=][^=]*\\)==/\\1<mark>\\2<\\/mark>/g")
	vim.cmd("silent! %s/==\\([^=][^=]*\\)==\\([[:punct:]]\\)/<mark>\\1<\\/mark>\\2/g")
	vim.cmd("silent! %s/==\\([^=][^=]*\\)==\\s/<mark>\\1<\\/mark> /g")
end

-- 创建命令和快捷键映射
vim.api.nvim_create_user_command("ReplaceMarkers", mark_highlight, {})
-- vim.keymap.set("n", "<leader>rm", replace_markers, { desc = "Replace == markers" })
