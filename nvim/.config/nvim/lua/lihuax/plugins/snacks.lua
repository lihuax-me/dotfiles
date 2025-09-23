return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		scroll = {
			animate = {
				duration = { step = 15, total = 250 },
				easing = "linear",
			},
			-- faster animation when repeating scroll after delay
			animate_repeat = {
				delay = 100, -- delay in ms before using the repeat animation
				duration = { step = 5, total = 50 },
				easing = "linear",
			},
			-- what buffers to animate
			filter = function(buf)
				return vim.g.snacks_scroll ~= false
					and vim.b[buf].snacks_scroll ~= false
					and vim.bo[buf].buftype ~= "terminal"
			end,
		},
		bigfile = { enabled = false },
		notifier = { enabled = false },
		quickfile = { enabled = false },
		statuscolumn = { enabled = false },
		words = { enabled = false },
		zen = {
			-- You can add any `Snacks.toggle` id here.
			-- Toggle state is restored when the window is closed.
			-- Toggle config options are NOT merged.
			---@type table<string, boolean>
			toggles = {
				dim = true,
				git_signs = false,
				mini_diff_signs = false,
				-- diagnostics = false,
				-- inlay_hints = false,
			},
			show = {
				statusline = false, -- can only be shown when using the global statusline
				tabline = false,
			},
			---@type snacks.win.Config
			win = { style = "zen" },
			--- Callback when the window is opened.
			---@param win snacks.win
			on_open = function(win) end,
			--- Callback when the window is closed.
			---@param win snacks.win
			on_close = function(win) end,
			--- Options for the `Snacks.zen.zoom()`
			---@type snacks.zen.Config
			zoom = {
				toggles = {},
				show = { statusline = true, tabline = true },
				win = {
					backdrop = false,
					width = 0, -- full width
				},
			},
		},
		dashboard = {
			width = 60,
			row = nil, -- dashboard position. nil for center
			col = nil, -- dashboard position. nil for center
			pane_gap = 4, -- empty columns between vertical panes
			autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
			-- These settings are used by some built-in sections
			preset = {
				-- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
				---@type fun(cmd:string, opts:table)|nil
				pick = nil,
				-- Used by the `keys` section to show keymaps.
				-- Set your curstom keymaps here.
				-- When using a function, the `items` argument are the default keymaps.
				---@type snacks.dashboard.Item[]
				keys = {
					{ icon = " ", key = "e", desc = "New File", action = ":ene | startinsert" },
					{
						icon = "󰹕 ",
						key = "n",
						desc = "Notes",
						-- action = ":NvimTreeOpen ~/Documents/ob_repo",
						action = ":cd $HOME/Documents/notes | Yazi",
					},
					{ icon = "󱗖 ", key = "d", desc = "Diary", action = "<leader>dd" },
					{
						icon = " ",
						key = "w",
						desc = "Blogs",
						action = ":cd $HOME/Documents/blog/src/content/posts | Yazi",
					},
					{
						icon = "󰸖 ",
						key = "b",
						desc = "Bookmarks",
						action = ":Telescope bookmarks list",
					},
					{
						-- icon = " ",
						icon = "󱋢 ",
						key = "r",
						desc = "Recent Files",
						action = ":lua Snacks.dashboard.pick('oldfiles')",
					},
					{
						icon = "󰱼 ",
						key = "f",
						desc = "Find File",
						action = ":lua Snacks.dashboard.pick('files')",
					},
					{
						icon = " ",
						key = "t",
						desc = "Find Text",
						action = ":lua Snacks.dashboard.pick('live_grep')",
					},
					{
						icon = " ",
						key = "c",
						desc = "Calendar",
						action = ":Calendar",
					},
					{
						icon = " ",
						key = "m",
						desc = "Mails",
						action = ":Mail",
					},
					{
						icon = "󰊢 ",
						key = "g",
						desc = "Lazygit",
						action = ":LazyGit",
						enabled = vim.fn.isdirectory(".git") == 1,
					},
					{
						icon = " ",
						desc = "Browse Repo",
						enabled = vim.fn.isdirectory(".git") == 1,
						padding = 1,
						key = "G",
						action = function()
							Snacks.gitbrowse()
						end,
					},
					{
						icon = " ",
						key = "C",
						desc = "Config",
						action = ":cd $HOME/.config/nvim | Yazi",
					},
					--{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
					{
						icon = "󰒲 ",
						key = "L",
						desc = "Lazy",
						action = ":Lazy",
						enabled = package.loaded.lazy ~= nil,
					},
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
				-- Used by the `header` section
				header = [[





███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝




]],
				-- 				headerr = [[
				-- ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
				-- ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⣠⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
				-- ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣡⣾⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⣿⣟⠻⣿⣿⣿⣿⣿⣿⣿⣿
				-- ⣿⣿⣿⣿⣿⣿⣿⣿⡿⢫⣷⣿⣿⣿⣿⣿⣿⣿⣾⣯⣿⡿⢧⡚⢷⣌⣽⣿⣿⣿⣿⣿⣶⡌⣿⣿⣿⣿⣿⣿
				-- ⣿⣿⣿⣿⣿⣿⣿⣿⠇⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣮⣇⣘⠿⢹⣿⣿⣿⣿⣿⣻⢿⣿⣿⣿⣿⣿
				-- ⣿⣿⣿⣿⣿⣿⣿⣿⠀⢸⣿⣿⡇⣿⣿⣿⣿⣿⣿⣿⣿⡟⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣻⣿⣿⣿⣿
				-- ⣿⣿⣿⣿⣿⣿⣿⡇⠀⣬⠏⣿⡇⢻⣿⣿⣿⣿⣿⣿⣿⣷⣼⣿⣿⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⢻⣿⣿⣿⣿
				-- ⣿⣿⣿⣿⣿⣿⣿⠀⠈⠁⠀⣿⡇⠘⡟⣿⣿⣿⣿⣿⣿⣿⣿⡏⠿⣿⣟⣿⣿⣿⣿⣿⣿⣿⣿⣇⣿⣿⣿⣿
				-- ⣿⣿⣿⣿⣿⣿⡏⠀⠀⠐⠀⢻⣇⠀⠀⠹⣿⣿⣿⣿⣿⣿⣩⡶⠼⠟⠻⠞⣿⡈⠻⣟⢻⣿⣿⣿⣿⣿⣿⣿
				-- ⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⢿⠀⡆⠀⠘⢿⢻⡿⣿⣧⣷⢣⣶⡃⢀⣾⡆⡋⣧⠙⢿⣿⣿⣟⣿⣿⣿⣿
				-- ⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⡥⠂⡐⠀⠁⠑⣾⣿⣿⣾⣿⣿⣿⡿⣷⣷⣿⣧⣾⣿⣿⣿⣿⣿⣿⣿
				-- ⣿⣿⡿⣿⣍⡴⠆⠀⠀⠀⠀⠀⠀⠀⠀⣼⣄⣀⣷⡄⣙⢿⣿⣿⣿⣿⣯⣶⣿⣿⢟⣾⣿⣿⢡⣿⣿⣿⣿⣿
				-- ⣿⡏⣾⣿⣿⣿⣷⣦⠀⠀⠀⢀⡀⠀⠀⠠⣭⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⣡⣾⣿⣿⢏⣾⣿⣿⣿⣿⣿
				-- ⣿⣿⣿⣿⣿⣿⣿⣿⡴⠀⠀⠀⠀⠀⠠⠀⠰⣿⣿⣿⣷⣿⠿⠿⣿⣿⣭⡶⣫⠔⢻⢿⢇⣾⣿⣿⣿⣿⣿⣿
				-- ⣿⣿⣿⡿⢫⣽⠟⣋⠀⠀⠀⠀⣶⣦⠀⠀⠀⠈⠻⣿⣿⣿⣾⣿⣿⣿⣿⡿⣣⣿⣿⢸⣾⣿⣿⣿⣿⣿⣿⣿
				-- ⡿⠛⣹⣶⣶⣶⣾⣿⣷⣦⣤⣤⣀⣀⠀⠀⠀⠀⠀⠀⠉⠛⠻⢿⣿⡿⠫⠾⠿⠋⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
				-- ⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣀⡆⣠⢀⣴⣏⡀⠀⠀⠀⠉⠀⠀⢀⣠⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
				-- ⠿⠛⠛⠛⠛⠛⠛⠻⢿⣿⣿⣿⣿⣯⣟⠷⢷⣿⡿⠋⠀⠀⠀⠀⣵⡀⢠⡿⠋⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
			},

			-- item field formatters
			formats = {
				--icon = function(item)
				--	if item.file and item.icon == "file" or item.icon == "directory" then
				--		return M.icon(item.file, item.icon)
				--	end
				--	return { item.icon, width = 2, hl = "icon" }
				--end,
				header = { "%s", align = "center" },
				file = function(item, ctx)
					local fname = vim.fn.fnamemodify(item.file, ":~")
					fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
					local dir, file = fname:match("^(.*)/(.+)$")
					return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
				end,
			},
			sections = {
				{
					section = "header",
					padding = 2,
				},
				-- { section = "footer" },
				-- { section = "rei" },
				{ section = "keys", gap = 1, padding = 1 },
				-- {
				-- 	pane = 2,
				-- 	section = "terminal",
				-- 	cmd = "chafa ~/.config/wall.png --format symbols --symbols vhalf --size 60x17 --stretch | tr -d '\r'; sleep .1",
				-- 	height = 17,
				-- 	padding = 3,
				-- },
				{ section = "startup" },
				{
					pane = 2,
					section = "terminal",
					cmd = "cat ~/.config/rei",
					-- cmd = "cat ~/.config/nerv",
					-- random = 10,
					indent = 10,
					height = 16,
					padding = 2,
				},
				{
					section = "terminal",
					icon = " ",
					title = "Github contributes",
					-- enabled = vim.fn.isdirectory(".git") == 0,
					cmd = "cat /tmp/gh_contri",
					-- random = 10,
					pane = 2,
					indent = 9,
					height = 8,
					-- padding = 1,
				},
				{
					pane = 2,
					icon = " ",
					title = "Recent Files",
					section = "recent_files",
					indent = 2,
					padding = 1,
				},
				{
					pane = 2,
					indent = 2,
					icon = " ",
					title = "Recent Projects",
					section = "projects",
					padding = 1,
				},
				{
					pane = 2,
					icon = " ",
					title = "Git Diff",
					section = "terminal",
					enabled = (vim.fn.isdirectory(".git") == 1)
						and (vim.fn.systemlist("git --no-pager diff --stat -B -M -C | wc -l")[1] + 0 > 0),
					cmd = "git --no-pager diff --stat -B -M -C",
					-- cmd = "git status --short --branch --renames",
					height = 5,
					padding = 1,
					ttl = 5 * 60,
					indent = 1,
				},
				{
					pane = 2,
					icon = " ",
					title = "Git Status",
					section = "terminal",
					enabled = (vim.fn.isdirectory(".git") == 1)
						and not (vim.fn.systemlist("git --no-pager diff --stat -B -M -C | wc -l")[1] + 0 > 0),
					cmd = "git status",
					-- cmd = "git status --short --branch --renames",
					height = 5,
					padding = 1,
					ttl = 5 * 60,
					indent = 2,
				},
				{
					pane = 2,
					section = "terminal",
					enabled = (vim.fn.isdirectory(".git") == 1)
						and (vim.fn.systemlist("git --no-pager diff --stat -B -M -C | wc -l")[1] + 0 > 5),
					cmd = "git --no-pager diff --stat -B -M -C | tail -n 1",
					height = 1,
					padding = 1,
					ttl = 5 * 60,
					indent = 4,
				},
			},
		},
		image = {
			formats = {
				"png",
				"jpg",
				"jpeg",
				"gif",
				"bmp",
				"webp",
				"tiff",
				"heic",
				"avif",
				"mp4",
				"mov",
				"avi",
				"mkv",
				"webm",
				"pdf",
			},
			force = false, -- try displaying the image, even if the terminal does not support it
			doc = {
				-- enable image viewer for documents
				-- a treesitter parser must be available for the enabled languages.
				enabled = true,
				-- render the image inline in the buffer
				-- if your env doesn't support unicode placeholders, this will be disabled
				-- takes precedence over `opts.float` on supported terminals
				inline = true,
				-- render the image in a floating window
				-- only used if `opts.inline` is disabled
				float = false,
				max_width = 60,
				max_height = 30,
				-- Set to `true`, to conceal the image text when rendering inline.
				-- (experimental)
				---@param lang string tree-sitter language
				---@param type snacks.image.Type image type
				-- conceal = function(lang, type)
				-- 	-- only conceal math expressions
				-- 	return type == "math"
				-- end,
			},
			img_dirs = { "img", "images", "assets", "static", "public", "media", "attachments" },
			-- window options applied to windows displaying image buffers
			-- an image buffer is a buffer with `filetype=image`
			wo = {
				wrap = false,
				number = false,
				relativenumber = false,
				cursorcolumn = false,
				signcolumn = "no",
				foldcolumn = "0",
				list = false,
				spell = false,
				statuscolumn = "",
			},
			cache = vim.fn.stdpath("cache") .. "/snacks/image",
			debug = {
				request = false,
				convert = false,
				placement = false,
			},
			env = {},
			-- icons used to show where an inline image is located that is
			-- rendered below the text.
			icons = {
				math = "󰪚 ",
				chart = "󰄧 ",
				image = " ",
			},
			---@class snacks.image.convert.Config
			convert = {
				notify = true, -- show a notification on error
				---@type snacks.image.args
				mermaid = function()
					local theme = vim.o.background == "light" and "neutral" or "dark"
					return { "-i", "{src}", "-o", "{file}", "-b", "transparent", "-t", theme, "-s", "{scale}" }
				end,
				---@type table<string,snacks.image.args>
				magick = {
					default = { "{src}[0]", "-scale", "1920x1080>" }, -- default for raster images
					vector = { "-density", 192, "{src}[0]" }, -- used by vector images like svg
					math = { "-density", 192, "{src}[0]", "-trim" },
					pdf = { "-density", 192, "{src}[0]", "-background", "white", "-alpha", "remove", "-trim" },
				},
			},
			math = {
				enabled = true, -- enable math expression rendering
				-- in the templates below, `${header}` comes from any section in your document,
				-- between a start/end header comment. Comment syntax is language-specific.
				-- * start comment: `// snacks: header start`
				-- * end comment:   `// snacks: header end`
				typst = {
					tpl = [[
        #set page(width: auto, height: auto, margin: (x: 2pt, y: 2pt))
        #show math.equation.where(block: false): set text(top-edge: "bounds", bottom-edge: "bounds")
        #set text(size: 12pt, fill: rgb("${color}"))
        ${header}
        ${content}]],
				},
				latex = {
					font_size = "Large", -- see https://www.sascha-frank.com/latex-font-size.html
					-- for latex documents, the doc packages are included automatically,
					-- but you can add more packages here. Useful for markdown documents.
					packages = { "amsmath", "amssymb", "amsfonts", "amscd", "mathtools" },
					tpl = [[
        \documentclass[preview,border=0pt,varwidth,12pt]{standalone}
        \usepackage{${packages}}
        \begin{document}
        ${header}
        { \${font_size} \selectfont
          \color[HTML]{${color}}
        ${content}}
        \end{document}]],
				},
			},
		},
	},

	keys = {
		{
			"<leader>z",
			function()
				Snacks.zen()
			end,
			desc = "Toggle Zen Mode",
		},
		{
			"<leader>Z",
			function()
				Snacks.zen.zoom()
			end,
			desc = "Toggle Zoom",
		},
		{
			"<leader>.",
			function()
				Snacks.scratch()
			end,
			desc = "Toggle Scratch Buffer",
		},
		{
			"<leader>S",
			function()
				Snacks.scratch.select()
			end,
			desc = "Select Scratch Buffer",
		},
	},
}
