-- List of supported scripting languages
local scriptLanguages = {
	python = "python",
	r = "R",
	rmd = "R",
	sh = "bash",
	julia = "julia",
	lua = "lua",
}

-- List of supported compiled languages
local compiledLanguages = {
	c = '"cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug"',
	cpp = '"cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug"',
	tex = "mklex",
}

--- Checks if current filetype is in a supported language list
-- @param isScriptLan boolean Whether to check against scripting languages (true) or compiled languages (false)
-- @return string|nil Language key if found
-- @return string|nil Language command if found
local function check_filetype(isScriptLan)
	local filetype = vim.bo.filetype
	local lang_list = isScriptLan and scriptLanguages or compiledLanguages

	for lang, lang_str in pairs(lang_list) do
		if filetype == lang then
			return lang, lang_str
		end
	end
end

--- Ensures toggleterm.nvim is loaded
local function check_togglerterm_loaded()
	if not pcall(require, "toggleterm") then
		vim.cmd("Lazy load toggleterm.nvim")
	end
end

--- Creates or reuses a terminal runner
-- @param cmd string Command to execute in the terminal
-- @param position string|nil Terminal position ("vertical" or "horizontal")
local function runner_term(cmd, position)
	check_togglerterm_loaded()
	position = position or "vertical"
	local size = (position == "horizontal") and 8 or 60

	local opencmd = 'ToggleTerm name=" runner" direction=' .. position .. " size=" .. size
	vim.cmd(opencmd)
	vim.cmd("TermExec cmd=" .. cmd .. ' name=" runner" dir=.')
end

--- Opens a runner for scripting languages
local function open_scriptlan_runner()
	local lang, cmd = check_filetype(true)
	if not lang then
		print("No supported scripting language detected")
		return
	end
	runner_term(cmd, "horizontal")
end

--- Opens a compiler for compiled languages
local function language_compiler()
	local lang, cmd = check_filetype(false)
	if not lang then
		print("No supported compiled language detected")
		return
	end
	runner_term(cmd, "horizontal")
end

--- Executes compiled language projects
-- @param lang string Language key (c, cpp, tex)
local function comilerlan_runner(lang)
	if lang == "c" or lang == "cpp" then
		vim.cmd('TermExec cmd="cmake --build build -j $(nproc)"')
		vim.cmd('TermExec cmd="./bin/main.bin"')
	elseif lang == "tex" then
		local filename = vim.fn.expand("%:t:r")
		vim.cmd("!evince output/" .. filename .. ".pdf &")
	end
end

--- Main execution function for running code
local function run()
	local lang, _ = check_filetype(true) -- First try scripting languages

	if not lang then
		lang, _ = check_filetype(false) -- Then try compiled languages
		if not lang then
			print("No supported language detected")
			return
		end
	end

	if scriptLanguages[lang] then
		vim.cmd("ToggleTermSendCurrentLine")
		vim.cmd("normal j")
	else
		comilerlan_runner(lang)
	end
end

----------------------------------------------------------------------------------------------
--- code from https://github.com/akinsho/toggleterm.nvim/issues/425?utm_source=chatgpt.com ---
----------------------------------------------------------------------------------------------
local function send_visual_lines()
	-- visual markers only update after leaving visual mode
	local esc = vim.api.nvim_replace_termcodes("<esc>", true, false, true)
	vim.api.nvim_feedkeys(esc, "x", false)

	-- get selected text
	local start_line, start_col = unpack(vim.api.nvim_buf_get_mark(0, "<"))
	local end_line, end_col = unpack(vim.api.nvim_buf_get_mark(0, ">"))
	local lines = vim.fn.getline(start_line, end_line)

	-- send selection with trimmed indent
	local cmd = ""
	local indent = nil
	for _, line in ipairs(lines) do
		if indent == nil and line:find("[^%s]") ~= nil then
			indent = line:find("[^%s]")
		end
		-- (i)python interpreter evaluates sent code on empty lines -> remove
		if not line:match("^%s*$") then
			cmd = cmd .. line:sub(indent or 1) .. string.char(13) -- trim indent
		end
	end
	require("toggleterm").exec(cmd, 1)
end
--------------------------------------------------------------------------------------------------
--- end code from https://github.com/akinsho/toggleterm.nvim/issues/425?utm_source=chatgpt.com ---
--------------------------------------------------------------------------------------------------
-- Create user commands
vim.api.nvim_create_user_command("ScriptlanRunner", open_scriptlan_runner, {})
vim.api.nvim_create_user_command("CompilelanRunner", language_compiler, {})
vim.api.nvim_create_user_command("RunRunner", run, {})
vim.api.nvim_create_user_command("RunChunk", send_visual_lines, {})

-- Set key mappings
local key = vim.api.nvim_set_keymap
key("n", "<F17>", "<CMD>ScriptlanRunner<CR>", { noremap = true, silent = true })
key("n", "<S-F5>", "<CMD>ScriptlanRunner<CR>", { noremap = true, silent = true })
key("n", "<F29>", "<CMD>CompilelanRunner<CR>", { noremap = true, silent = true })
key("n", "<C-F5>", "<CMD>CompilelanRunner<CR>", { noremap = true, silent = true })
key("n", "<F5>", "<CMD>RunRunner<CR>", { noremap = true, silent = true })
key("v", "<F5>", "<CMD>RunChunk<CR>", { noremap = true, silent = true })
