-- nvim-fanyi-callout.lua
-- All comments are in English as requested.

local M = {}

-- Normalize path to user's fanyi script
local FANYI = vim.fn.expand("~/.config/../Documents/bin/fanyi") -- robust expand of ~/Documents/bin/fanyi
-- If you know the path is stable, you can simply write:
-- local FANYI = vim.fn.expand("~/Documents/bin/fanyi")

-- Split string by newline into a Lua table
local function split_lines(s)
	local t = {}
	if not s or s == "" then
		return t
	end
	for line in (s .. "\n"):gmatch("([^\n]*)\n") do
		table.insert(t, line)
	end
	return t
end

-- Trim leading/trailing blank lines
local function trim_blank_lines(lines)
	local first, last = 1, #lines
	while first <= last and lines[first]:match("^%s*$") do
		first = first + 1
	end
	while last >= first and lines[last]:match("^%s*$") do
		last = last - 1
	end
	local out = {}
	for i = first, last do
		table.insert(out, lines[i])
	end
	return out
end

-- Build Markdown callout lines
local function build_callout(lines, tag)
	lines = trim_blank_lines(lines)
	if #lines == 0 then
		return nil, "Empty translation output"
	end

	local title = lines[1]
	local body = {}
	for i = 2, #lines do
		table.insert(body, lines[i])
	end

	-- Prefix with Markdown callout
	local out = {}
	table.insert(out, string.format("> [!%s] %s", tag, title))
	table.insert(out, ">") -- a blank line in callout
	if #body == 0 then
	-- nothing else
	else
		for _, ln in ipairs(body) do
			if ln == "" then
				table.insert(out, "> ")
			else
				table.insert(out, "> " .. ln)
			end
		end
	end
	return out
end

-- Insert lines below the current cursor line
local function insert_lines_below(lines)
	local bufnr = vim.api.nvim_get_current_buf()
	local row = vim.api.nvim_win_get_cursor(0)[1] -- 1-based
	-- Insert after current row: start and end are 0-based, end-exclusive
	vim.api.nvim_buf_set_lines(bufnr, row, row, true, lines)
end

-- Run external command; prefer vim.system (Neovim >= 0.10), fallback to vim.fn.systemlist
local function run_fanyi_async(args, on_done)
	if vim.system then
		vim.system(args, { text = true }, function(obj)
			if obj.code ~= 0 then
				on_done(nil, string.format("Command failed (%d): %s", obj.code, obj.stderr or ""))
			else
				on_done(split_lines(obj.stdout or ""), nil)
			end
		end)
	else
		-- Synchronous fallback
		local out = vim.fn.systemlist(args)
		local code = vim.v.shell_error
		if code ~= 0 then
			on_done(nil, string.format("Command failed (%d): %s", code, table.concat(out or {}, "\n")))
		else
			on_done(out, nil)
		end
	end
end

-- Public entry: call fanyi and insert a Markdown callout
function M.fanyi_callout(opts)
	opts = opts or {}
	local tag = opts.tag or "TODO"

	-- Build command: -n for no color, -p to print to current terminal (our script supports -p), -b optional
	local cmd = { FANYI, "-n", "-p" }
	if opts.brief then
		table.insert(cmd, 2, "-b")
	end -- insert after executable

	-- Safety checks
	if vim.fn.filereadable(FANYI) ~= 1 then
		vim.notify("fanyi script not found: " .. FANYI, vim.log.levels.ERROR)
		return
	end

	-- Run and handle result
	run_fanyi_async(cmd, function(lines, err)
		if err then
			vim.schedule(function()
				vim.notify("fanyi failed: " .. err, vim.log.levels.ERROR)
			end)
			return
		end
		local callout, msg = build_callout(lines, tag)
		if not callout then
			vim.schedule(function()
				vim.notify("fanyi output empty: " .. (msg or ""), vim.log.levels.WARN)
			end)
			return
		end
		vim.schedule(function()
			insert_lines_below(callout)
			-- Optional: move cursor to the blank line after inserted block
			local row = vim.api.nvim_win_get_cursor(0)[1]
			vim.api.nvim_win_set_cursor(0, { row + #callout, 0 })
		end)
	end)
end

-- Create a user command: :FanyiCallout[!]  (! means brief)
vim.api.nvim_create_user_command("FanyiCallout", function(cmdopts)
	local brief = cmdopts.bang -- :FanyiCallout! => brief mode
	M.fanyi_callout({ tag = "TODO", brief = brief })
end, {
	bang = true,
	desc = "Insert Markdown callout from fanyi (-n -p). Use ! for brief (-b).",
})

-- Keymaps (normal mode):
-- <leader>fy => default (full output); <leader>fY => brief (-b)
vim.keymap.set("n", "<leader>fy", function()
	M.fanyi_callout({ tag = "TODO", brief = false })
end, { desc = "Fanyi callout insert" })
vim.keymap.set("n", "<leader>fY", function()
	M.fanyi_callout({ tag = "TODO", brief = true })
end, { desc = "Fanyi callout insert (brief)" })

return M
