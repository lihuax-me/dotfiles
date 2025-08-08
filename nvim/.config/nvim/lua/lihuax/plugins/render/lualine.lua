-- return {
-- 	"nvim-lualine/lualine.nvim",
-- 	dependencies = { "nvim-tree/nvim-web-devicons" },
-- 	config = function()
-- 		local lualine = require("lualine")
-- 		local lazy_status = require("lazy.status") -- to configure lazy pending updates count
--
-- 		--local colors = {
-- 		--	blue = "#65D1FF",
-- 		--	green = "#3EFFDC",
-- 		--	violet = "#FF61EF",
-- 		--	yellow = "#FFDA7B",
-- 		--	red = "#FF4A4A",
-- 		--	fg = "#c3ccdc",
-- 		--	bg = "#112638",
-- 		--	inactive_bg = "#2c3043",
-- 		--}
--
-- 		--local my_lualine_theme = {
-- 		--	normal = {
-- 		--		a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
-- 		--		b = { bg = colors.bg, fg = colors.fg },
-- 		--		c = { bg = colors.bg, fg = colors.fg },
-- 		--	},
-- 		--	insert = {
-- 		--		a = { bg = colors.green, fg = colors.bg, gui = "bold" },
-- 		--		b = { bg = colors.bg, fg = colors.fg },
-- 		--		c = { bg = colors.bg, fg = colors.fg },
-- 		--	},
-- 		--	visual = {
-- 		--		a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
-- 		--		b = { bg = colors.bg, fg = colors.fg },
-- 		--		c = { bg = colors.bg, fg = colors.fg },
-- 		--	},
-- 		--	command = {
-- 		--		a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
-- 		--		b = { bg = colors.bg, fg = colors.fg },
-- 		--		c = { bg = colors.bg, fg = colors.fg },
-- 		--	},
-- 		--	replace = {
-- 		--		a = { bg = colors.red, fg = colors.bg, gui = "bold" },
-- 		--		b = { bg = colors.bg, fg = colors.fg },
-- 		--		c = { bg = colors.bg, fg = colors.fg },
-- 		--	},
-- 		--	inactive = {
-- 		--		a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
-- 		--		b = { bg = colors.inactive_bg, fg = colors.semilightgray },
-- 		--		c = { bg = colors.inactive_bg, fg = colors.semilightgray },
-- 		--	},
-- 		--}
--
-- 		local colors = {
-- 			blue = "#80a0ff",
-- 			cyan = "#79dac8",
-- 			black = "#080808",
-- 			white = "#c6c6c6",
-- 			red = "#ff5189",
-- 			violet = "#d183e8",
-- 			grey = "#303030",
-- 		}
--
-- 		local bubbles_theme = {
-- 			normal = {
-- 				a = { fg = colors.black, bg = colors.violet },
-- 				b = { fg = colors.white, bg = colors.grey },
-- 				c = { fg = colors.white },
-- 			},
--
-- 			insert = { a = { fg = colors.black, bg = colors.blue } },
-- 			visual = { a = { fg = colors.black, bg = colors.cyan } },
-- 			replace = { a = { fg = colors.black, bg = colors.red } },
--
-- 			inactive = {
-- 				a = { fg = colors.white, bg = colors.black },
-- 				b = { fg = colors.white, bg = colors.black },
-- 				c = { fg = colors.white },
-- 			},
-- 		}
--
-- 		-- configure lualine with modified theme
-- 		-- local function wordcount()
-- 		-- 	return tostring(vim.fn.wordcount().words) .. " words"
-- 		-- end
--
-- 		-- Function to count English words and Chinese characters
-- 		local function wordcount()
-- 			local text = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, true), " ")
--
-- 			-- Count Chinese characters
-- 			-- local chinese_count = select(2, text:gsub("[%z\1-\127]", ""))
-- 			-- local chinese_count = select(2, text:gsub("[^\x00-\xff]", ""))
-- 			local chinese_count = select(2, text:gsub("[\194-\244][\128-\191]+", ""))
--
-- 			-- Count English words
-- 			local english_count = select(2, text:gsub("%a+", ""))
--
-- 			-- Return total count
-- 			return tostring(chinese_count + english_count) .. " "
-- 		end
--
-- 		-- local function charcount()
-- 		-- 	return tostring(vim.fn.strdisplaywidth(vim.api.nvim_get_current_line())) .. " chars"
-- 		-- end
--
-- 		-- local function charcount()
-- 		-- 	local chars = 0
-- 		-- 	for i = 1, vim.fn.line("$") do
-- 		-- 		chars = chars + vim.fn.strdisplaywidth(vim.fn.getline(i))
-- 		-- 	end
-- 		-- 	return tostring(chars) .. " chars"
-- 		-- end
--
-- 		local function is_markdown()
-- 			return vim.bo.filetype == "markdown" or vim.bo.filetype == "asciidoc"
-- 		end
--
-- 		local function pomo()
-- 			local timer = require("pomo").get_first_to_finish()
-- 			if timer == nil then
-- 				return ""
-- 			end
--
-- 			return "󰄉 " .. tostring(timer)
-- 		end
--
-- 		local function pomo_loaded()
-- 			if package.loaded["pomo"] ~= nil then
-- 				return true
-- 			else
-- 				return false
-- 			end
-- 		end
--
-- 		lualine.setup({
-- 			-- options = {
-- 			-- 	theme = my_lualine_theme,
-- 			-- },
-- 			options = {
-- 				theme = bubbles_theme,
-- 				component_separators = { left = ")", right = "(" },
-- 				section_separators = { left = "", right = "" },
-- 			},
-- 			sections = {
-- 				lualine_c = {
-- 					-- 0 = just filename, 1 = relative path, 2 = absolute path
-- 					-- { "filename", path = 0 },
-- 					"filesize",
-- 					{ "progress" },
-- 					{ "location" },
-- 				},
-- 				lualine_x = {
-- 					-- {
-- 					-- 	lazy_status.updates,
-- 					-- 	cond = lazy_status.has_updates,
-- 					-- 	color = { fg = "#ff9e64" },
-- 					-- },
-- 					{ pomo, cond = pomo_loaded },
-- 					{ wordcount, cond = is_markdown },
-- 					--{ charcount, cond = is_markdown },
-- 					{ "encoding" },
-- 					{ "fileformat" },
-- 					{ "filetype" },
-- 				},
-- 				lualine_z = {
-- 					{ "filename", path = 0 },
-- 				},
-- 			},
-- 		})
-- 	end,
-- }

local bo = vim.bo
local fn = vim.fn

--------------------------------------------------------------------------------

-- displays irregular indentation and linebreaks, displays nothing when all is good
-- selene: allow(high_cyclomatic_complexity)
local function irregularWhitespace()
	-- USER CONFIG
	-- filetypes and the number of spaces they use. Omit or set to nil to use tabs for that filetype.
	local spaceFiletypes = { python = 4, yaml = 2, cpp = 2 }
	local ignoredFiletypes = { "css", "markdown", "gitcommit" }
	local linebreakType = "unix" ---@type "unix" | "mac" | "dos"

	-- vars & guard
	local usesSpaces = bo.expandtab
	local usesTabs = not bo.expandtab
	local brUsed = bo.fileformat
	local ft = bo.filetype
	local width = bo.tabstop
	if vim.tbl_contains(ignoredFiletypes, ft) or fn.mode() ~= "n" or bo.buftype ~= "" then
		return ""
	end

	-- non-default indentation setting (e.g. changed via indent-o-matic)
	local nonDefaultSetting = ""
	local spaceFtsOnly = vim.tbl_keys(spaceFiletypes)
	if (usesSpaces and not vim.tbl_contains(spaceFtsOnly, ft)) or (usesSpaces and width ~= spaceFiletypes[ft]) then
		nonDefaultSetting = " " .. tostring(width) .. "󱁐  "
	elseif usesTabs and vim.tbl_contains(spaceFtsOnly, ft) then
		nonDefaultSetting = " 󰌒 " .. tostring(width)(" ")
	end

	-- wrong or mixed indentation
	local hasTabs = fn.search("^\t", "nw") > 0
	local hasSpaces = fn.search("^ ", "nw") > 0
	-- exception, jsdocs: space not followed by "*"
	if bo.filetype == "javascript" then
		hasSpaces = fn.search([[^ \(\*\)\@!]], "nw") > 0
	end
	local wrongIndent = ""
	if usesTabs and hasSpaces then
		wrongIndent = " 󱁐 "
	elseif usesSpaces and hasTabs then
		wrongIndent = " 󰌒 "
	elseif hasTabs and hasSpaces then
		wrongIndent = " 󱁐 + 󰌒 "
	end

	-- line breaks
	local linebreakIcon = ""
	if brUsed ~= linebreakType then
		if brUsed == "unix" then
			linebreakIcon = " "
		elseif brUsed == "mac" then
			linebreakIcon = " "
		elseif brUsed == "dos" then
			linebreakIcon = " "
		end
	end

	return nonDefaultSetting .. wrongIndent .. linebreakIcon
end

--------------------------------------------------------------------------------

--- https://github.com/nvim-lualine/lualine.nvim/blob/master/lua/lualine/components/branch/git_branch.lua#L118
---@nodiscard
---@return boolean
local function isStandardBranch()
	-- checking via lualine API, to not call git outself
	local curBranch = require("lualine.components.branch.git_branch").get_branch()
	local notMainBranch = curBranch ~= "main" and curBranch ~= "master"
	local validFiletype = bo.filetype ~= "help" -- vim help files are located in a git repo
	local notSpecialBuffer = bo.buftype == ""
	return notMainBranch and validFiletype and notSpecialBuffer
end

--------------------------------------------------------------------------------

local function selectionCount()
	local isVisualMode = fn.mode():find("[Vv]")
	if not isVisualMode then
		return ""
	end
	local starts = fn.line("v")
	local ends = fn.line(".")
	local lines = starts <= ends and ends - starts + 1 or starts - ends + 1
	return " " .. tostring(lines) .. "L " .. tostring(fn.wordcount().visual_chars) .. "C"
end

-- -- shows global mark M
-- vim.api.nvim_del_mark("M") -- reset on session start
-- local function markM()
-- 	local markObj = vim.api.nvim_get_mark("M", {})
-- 	local markLn = markObj[1]
-- 	local markBufname = vim.fs.basename(markObj[4])
-- 	if markBufname == "" then
-- 		return ""
-- 	end -- mark not set
-- 	return " " .. markBufname .. ":" .. markLn
-- end

-- 定义函数用于显示任意标记的名称和位置
local function markStatus(mark)
	-- 获取标记信息
	local markObj = vim.api.nvim_get_mark(mark, {})
	local markLn = markObj[1]
	local markBufname = vim.fs.basename(markObj[4])

	-- 如果标记没有设置（文件名为空），则返回空字符串
	if markBufname == "" then
		return ""
	end

	-- 返回标记信息：图标 + 文件名 + 行号
	return " " .. "[" .. mark .. "]" .. markBufname .. ":" .. markLn
end

-- 调用 markStatus 函数动态获取多个标记的状态
local function marksStatus()
	local marks = { "A", "B", "M", "N", "I", "J" } -- 可以在这里添加其他标记
	local status = ""

	for _, mark in ipairs(marks) do
		local markInfo = markStatus(mark)
		if markInfo ~= "" then
			status = status .. markInfo .. "  "
		end
	end

	return status
end

-- only show the clock when fullscreen (= it covers the menubar clock)
local function clock()
	if vim.opt.columns:get() < 110 or vim.opt.lines:get() < 25 then
		return ""
	end

	local time = tostring(os.date()):sub(17, 21)
	if os.time() % 2 == 1 then
		time = time:gsub(":", " ")
	end -- make the `:` blink
	return time
end

-- wrapper to not require navic directly
-- local function navicBreadcrumbs()
-- 	if bo.filetype == "css" or not require("nvim-navic").is_available() then
-- 		return ""
-- 	end
-- 	return require("nvim-navic").get_location()
-- end

--------------------------------------------------------------------------------

---improves upon the default statusline components by having properly working icons
---@nodiscard
local function currentFile()
	local maxLen = 25

	local ext = fn.expand("%:e")
	local ft = bo.filetype
	local name = fn.expand("%:t")
	if ft == "octo" and name:find("^%d$") then
		name = "#" .. name
	elseif ft == "TelescopePrompt" then
		name = "Telescope"
	end

	local deviconsInstalled, devicons = pcall(require, "nvim-web-devicons")
	local ftOrExt = ext ~= "" and ext or ft
	if ftOrExt == "javascript" then
		ftOrExt = "js"
	end
	if ftOrExt == "typescript" then
		ftOrExt = "ts"
	end
	if ftOrExt == "markdown" then
		ftOrExt = "md"
	end
	if ftOrExt == "vimrc" then
		ftOrExt = "vim"
	end
	local icon = deviconsInstalled and devicons.get_icon(name, ftOrExt) or ""
	-- add sourcegraph icon for clarity
	if fn.expand("%"):find("^sg") then
		icon = "󰓁 " .. icon
	end

	-- truncate
	local nameNoExt = name:gsub("%.%w+$", "")
	if #nameNoExt > maxLen then
		name = nameNoExt:sub(1, maxLen) .. "…" .. ext
	end

	if icon == "" then
		return name
	end
	return icon .. " " .. name
end

--------------------------------------------------------------------------------

-- FIX Add missing buffer names for current file component
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "lazy", "mason", "TelescopePrompt", "noice" },
	callback = function()
		local name = vim.fn.expand("<amatch>")
		name = name:sub(1, 1):upper() .. name:sub(2) -- capitalize
		pcall(vim.api.nvim_buf_set_name, 0, name)
	end,
})

-- local function charcount()
-- 	return tostring(vim.fn.strdisplaywidth(vim.api.nvim_get_current_line())) .. " chars"
-- end

-- local function charcount()
-- 	local chars = 0
-- 	for i = 1, vim.fn.line("$") do
-- 		chars = chars + vim.fn.strdisplaywidth(vim.fn.getline(i))
-- 	end
-- 	return tostring(chars) .. " chars"
-- end

local function wordcount()
	local text = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, true), " ")

	-- Count Chinese characters
	-- local chinese_count = select(2, text:gsub("[%z\1-\127]", ""))
	-- local chinese_count = select(2, text:gsub("[^\x00-\xff]", ""))
	local chinese_count = select(2, text:gsub("[\194-\244][\128-\191]+", ""))

	-- Count English words
	local english_count = select(2, text:gsub("%a+", ""))

	-- Return total count
	return tostring(chinese_count + english_count) .. " "
end

local function is_markdown()
	return vim.bo.filetype == "markdown" or vim.bo.filetype == "asciidoc"
end

local function pomo()
	local timer = require("pomo").get_first_to_finish()
	if timer == nil then
		return ""
	end

	return "󰄉 " .. tostring(timer)
end

local function pomo_loaded()
	if package.loaded["pomo"] ~= nil then
		return true
	else
		return false
	end
end

-- nerdfont: powerline icons have the prefix 'ple-'
-- local bottomSeparators = { left = "", right = "" }
-- local topSeparators = { left = "", right = "" }
local bottomSeparators = { left = "", right = "" }
local emptySeparators = { left = "", right = "" }
local roundSeparators = { left = ")", right = "(" }

local lualineConfig = {
	-- INFO using the tabline will override vim's default tabline, so the tabline
	-- should always include the tab element
	tabline = {
		lualine_a = {
			"[[]]",
			-- section_separators = emptySeparators,
		},
		lualine_b = {
			{
				"tabs",
				mode = 1,
				max_length = vim.o.columns * 0.7,
				section_separators = emptySeparators,
				-- cond = function()
				-- 	return fn.tabpagenr("$") > 1
				-- end,
			},
		},
		-- { "buffers", section_separators = emptySeparators },
		-- { section_separators = emptySeparators },
		lualine_c = {},
		lualine_x = {},
		-- INFO dap and recording status defined in the respective plugin configs
		-- for lualine_y and lualine_z for their lazy loading
		lualine_y = {},
		lualine_z = {
			{ marksStatus },
			{ clock, section_separators = emptySeparators },
		},
	},
	sections = {
		lualine_a = {
			-- { "branch", cond = isStandardBranch },
			{ "mode" },
		},
		lualine_b = {
			-- { currentFile },
			{ "branch" },
			"diff",
			-- 	{ require("funcs.alt-alt").altFileStatusline },
		},
		lualine_c = {
			-- 	{ require("funcs.quickfix").counter },
			{
				-- "location",
				"diagnostics",
				symbols = { error = "󰅚 ", warn = " ", info = "󰋽 ", hint = "󰘥 " },
			},
		},
		lualine_x = {
			-- { irregularWhitespace },
			{ pomo, cond = pomo_loaded },
			{ wordcount, cond = is_markdown },
			"filesize",
			{ "encoding" },
			{ "fileformat" },
			{ "filetype" },
		},
		lualine_y = {
			"location",
		},
		lualine_z = {
			{ selectionCount, padding = { left = 0, right = 1 } },
			-- "location",
			{ currentFile },
		},
	},
	options = {
		refresh = { statusline = 1000 },
		ignore_focus = {
			"DressingInput",
			"DressingSelect",
			"ccc-ui",
		},
		globalstatus = true,
		always_show_tabline = false,

		component_separators = { left = ")", right = "(" },
		section_separators = { left = "", right = "" },
		-- component_separators = roundSeparators,
		-- section_separators = bottomSeparators,
	},
}

--------------------------------------------------------------------------------

return {
	"nvim-lualine/lualine.nvim",
	lazy = false, -- load immediately so there is no flickering
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = lualineConfig,
}
