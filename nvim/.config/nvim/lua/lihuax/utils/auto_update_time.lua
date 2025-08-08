local M = {}

--- Update a line matching a pattern with today's date, optionally at a specific line.
--- @param pattern string Regex pattern to match the target line
--- @param replacement_format string Format string for os.date (e.g., "update: %Y-%m-%d %H:%M:%S")
--- @param check_lines integer|nil If specified, only checks this line number (1-based), otherwise checks entire file
M.update_date_field = function(pattern, replacement_format, check_lines)
	local filetypes = { "markdown", "tex", "text" }
	local ft = vim.bo.filetype
	if not vim.tbl_contains(filetypes, ft) then
		return
	end

	local bufnr = vim.api.nvim_get_current_buf()
	local total_lines = vim.api.nvim_buf_line_count(bufnr)
	local check_upto = check_lines or total_lines

	-- Prevent out-of-bounds access
	check_upto = math.min(check_upto, total_lines)

	local new_line = os.date(replacement_format)
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, check_upto, false)

	for i, l in ipairs(lines) do
		if l:match(pattern) then
			vim.api.nvim_buf_set_lines(bufnr, i - 1, i, false, { new_line })
			return
		end
	end
end

return M
