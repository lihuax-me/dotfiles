local function make_anki()
	local start_line, end_line = vim.fn.search("^\\s*$", "bnW"), vim.fn.search("^\\s*$", "nW")
	if start_line == 0 then
		start_line = 1
	end -- If no empty line is found at the beginning, default to line 1
	if end_line == 0 then
		end_line = vim.fn.line("$")
	end -- If no empty line is found at the end, default to last line of file

	-- Process each line to format as a block quote
	for i = start_line, end_line do
		local line_text = vim.fn.getline(i)
		if i == start_line then
			-- Skip processing for the first empty line
		elseif i == end_line then
			-- Skip processing for the last empty line
		elseif i == start_line + 1 then
			-- Add `> [!ANKI] ` prefix to the first content line
			vim.fn.setline(i, "> [!ANKI] " .. line_text)
		else
			-- Add `> ` prefix to all other content lines
			vim.fn.setline(i, "> " .. line_text)
		end
	end
end

local function make_anki_visual()
	-- Get the visual selection range
	local start_line = vim.fn.line("'<")
	local end_line = vim.fn.line("'>")

	-- Process each selected line to format as a block quote
	for i = start_line, end_line - 1 do
		local line_text = vim.fn.getline(i)
		if i == start_line then
			-- Add `> [!ANKI] ` prefix to the first line
			vim.fn.setline(i, "> [!ANKI] " .. line_text)
		elseif i == start_line + 1 and line_text == "" then
			-- If second line is empty, delete it along with its newline
			vim.api.nvim_buf_set_lines(0, i - 1, i, false, {})
			line_text = vim.fn.getline(i)
			vim.fn.setline(i, "> " .. line_text)
		else
			-- Add `> ` prefix to all other lines
			vim.fn.setline(i, "> " .. line_text)
		end
	end
end

vim.api.nvim_create_user_command("MakeAnki", make_anki, {})
vim.api.nvim_create_user_command("MakeAnkiVisual", make_anki_visual, { range = true })
vim.api.nvim_set_keymap("n", "<leader>ak", ":MakeAnki<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>ak", ":MakeAnkiVisual<CR>", { noremap = true, silent = true })
