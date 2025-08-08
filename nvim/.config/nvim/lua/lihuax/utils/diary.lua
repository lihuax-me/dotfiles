-- Requires `luatz` installed via luarocks
-- luarocks install luatz

local luatz = require("luatz")
local M = {}

M.BASE_DIR = "/home/lihuax/Onedrive/work/ob_repo/diary"

-- Get ISO week number using luatz(but start with Sunday)
function M.getWeekNumberOfYear()
	local date = luatz.now()

	if date:strftime("%u") == "7" then
		date.day = date.day + 1
		date:normalise()
	end

	return date:strftime("%V")
end

function M.touch_today_diary()
	local date = luatz.now()
	local year = date:strftime("%G")
	local month_abbr = date:strftime("%b")
	local month = date:strftime("%m")
	local day = date:strftime("%d")

	local formatted_date = string.format("Diary_%04d-%02d-%02d", year, month, day)
	local month_path = string.format("%s/%04d/%s", M.BASE_DIR, year, month_abbr)
	local file_path = string.format("%s/%s.md", month_path, formatted_date)
	local gpg_file_path = file_path .. ".gpg"

	vim.fn.mkdir(month_path, "p")

	if vim.fn.filereadable(gpg_file_path) == 1 then
		vim.cmd("edit " .. vim.fn.fnameescape(gpg_file_path))
	elseif vim.fn.filereadable(file_path) == 1 then
		vim.cmd("edit " .. vim.fn.fnameescape(file_path))
	else
		local file = io.open(file_path, "a")
		if file then
			file:close()
			vim.cmd("edit " .. vim.fn.fnameescape(file_path))
			-- print("Today's diary has been created: " .. file_path)
			vim.cmd("Template diary")
		else
			print("Error: Unable to create the diary file.")
		end
	end
end

function M.touch_weekly_journal()
	local date = luatz.now()
	local iso_year = date:strftime("%G")
	local week_number = M.getWeekNumberOfYear()

	local year_path = string.format("%s/%04d", M.BASE_DIR, iso_year)
	local file_path = string.format("%s/%04dW%02d.md", year_path, iso_year, week_number)
	local gpg_file_path = file_path .. ".gpg"

	vim.fn.mkdir(year_path, "p")

	if vim.fn.filereadable(gpg_file_path) == 1 then
		vim.cmd("edit " .. vim.fn.fnameescape(gpg_file_path))
	elseif vim.fn.filereadable(file_path) == 1 then
		vim.cmd("edit " .. vim.fn.fnameescape(file_path))
	else
		local file = io.open(file_path, "a")
		if file then
			file:close()
			-- print("Weekly journal has been created: " .. file_path)
			vim.cmd("edit " .. vim.fn.fnameescape(file_path))
			vim.cmd("Template weekly")
		else
			print("Error: Unable to create the weekly journal file.")
		end
	end
end

function M.touch_dev_weekly_journal()
	local date = luatz.now()
	local iso_year = date:get_iso_year()
	local week_number = date:get_iso_week()

	local base_path = vim.fn.getcwd()
	local dev_docs_path = base_path .. "/devDocs"
	local file_path = string.format("%s/%04dW%02d.md", dev_docs_path, iso_year, week_number)
	local gpg_file_path = file_path .. ".gpg"

	if vim.fn.isdirectory(dev_docs_path) == 0 then
		print("Error: The 'devDocs' directory does not exist. Please create it in the project root.")
		return
	end

	if vim.fn.filereadable(gpg_file_path) == 1 then
		vim.cmd("edit " .. vim.fn.fnameescape(gpg_file_path))
	elseif vim.fn.filereadable(file_path) == 1 then
		vim.cmd("edit " .. vim.fn.fnameescape(file_path))
	else
		local file = io.open(file_path, "a")
		if file then
			file:close()
			print("Development weekly journal has been created: " .. file_path)
			vim.cmd("edit " .. vim.fn.fnameescape(file_path))
		else
			print("Error: Unable to create the development weekly journal file.")
		end
	end
end

return M
