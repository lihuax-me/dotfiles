return {
	"mistricky/codesnap.nvim",
	build = "make build_generator",
	keys = {
		{ "<leader>sc", "<cmd>CodeSnap<cr>", mode = "n", desc = "Save selected code snapshot into clipboard" },
		{ "<leader>sp", "<cmd>CodeSnapSave<cr>", mode = "n", desc = "Save selected code snapshot in ~/Pictures" },
		{ "<leader>ss", "<cmd>CodeSnapHighlight<cr>", mode = "n", desc = "Save selected code snap with highlight" },
	},
	opts = {
		save_path = "~/Pictures/codesnap/",
		has_breadcrumbs = true,
		bg_theme = "grape",
		code_font_family = "Maple Mono NF CN",
		show_workspace = true,
		has_line_number = true,
		watermark = " @lihuax-lab",
	},
}

-- BUG: Stack overflow, confilict with noise.nvim
-- return {
-- 	"krivahtoo/silicon.nvim",
-- 	lazy = "true",
-- 	cmd = "Silicon",
-- 	build = "./install.sh",
-- 	config = function()
-- 		require("silicon").setup({
-- 			font = "Maple Mono NF CN",
-- 			theme = "Monokai Extended",
-- 			background = "#87f",
-- 			pad_horiz = 100, -- (number) The horizontal padding.
-- 			pad_vert = 80, -- (number) The vertical padding.
-- 			line_pad = 0, -- (number) The padding between lines.
-- 			tab_width = 4, -- (number) The tab width for the screenshot.
-- 			gobble = false, -- (boolean) Whether to trim extra indentation.
-- 			highlight_selection = false, -- (boolean) Whether to capture the whole file and highlight selected lines.
-- 			round_corner = true,
-- 			window_controls = true, -- (boolean) Whether to show window controls (minimize, maximize, close) in the screenshot.
-- 			window_title = function()
-- 				return vim.fn.fnamemodify(vim.fn.bufname(vim.fn.bufnr()), ":~:.")
-- 			end,
-- 			line_number = true,
--
-- 			-- Output configuration for the saved image
-- 			output = {
-- 				-- (string) The full path of the file to save to.
-- 				file = "",
-- 				-- (boolean) Whether to copy the image to clipboard instead of saving to file.
-- 				clipboard = false,
-- 				-- (string) Where to save images, defaults to the current directory.
-- 				path = "/home/lihuax/Pictures/Silicon/",
-- 				-- (string) The filename format to use. Can include placeholders for date and time.
-- 				-- https://time-rs.github.io/book/api/format-description.html#components
-- 				format = "silicon_[year][month][day]_[hour][minute][second].png",
-- 			},
--
-- 			shadow = {
-- 				blur_radius = 0.0, -- (number) The blur radius for the shadow, set to 0.0 for no shadow.
-- 				offset_x = 0, -- (number) The horizontal offset for the shadow.
-- 				offset_y = 0, -- (number) The vertical offset for the shadow.
-- 				color = "#555", -- (string) The color for the shadow.
-- 			},
--
-- 			watermark = {
-- 				text = " @zehua0417",
-- 				style = "bold",
-- 				color = "#222",
-- 			},
-- 		})
-- 	end,
-- }

-- return {
-- 	"michaelrommel/nvim-silicon",
-- 	lazy = true,
-- 	cmd = "Silicon",
-- 	main = "nvim-silicon",
-- 	opts = {
-- 		-- Configuration here, or leave empty to use defaults
-- 		-- disable_defaults will disable all builtin default settings apart
-- 		-- from the base arguments, that are needed to call silicon at all, see
-- 		-- mandatory_options below, also those options can be overridden
-- 		-- all of the settings could be overridden in the lua setup call,
-- 		-- but this clashes with the use of an external silicon --config=file,
-- 		-- see issue #9
-- 		disable_defaults = false,
-- 		-- turn on debug messages
-- 		debug = false,
-- 		-- most of them could be overridden with other
-- 		-- the font settings with size and fallback font
-- 		-- Example: font = "VictorMono NF=34;Noto Emoji",
-- 		-- font = "Maple Mono NF CN=14",
-- 		-- the theme to use, depends on themes available to silicon
-- 		theme = "gruvbox-dark",
-- 		-- the background color outside the rendered os window
-- 		-- (in hexcode string e.g "#076678")
-- 		background = "#87f",
-- 		-- a path to a background image
-- 		background_image = nil,
-- 		-- the paddings to either side
-- 		pad_horiz = 100,
-- 		pad_vert = 80,
-- 		-- whether to have the os window rendered with rounded corners
-- 		no_round_corner = false,
-- 		-- whether to put the close, minimize, maximise traffic light
-- 		-- controls on the border
-- 		no_window_controls = false,
-- 		-- whether to turn off the line numbers
-- 		no_line_number = false,
-- 		-- with which number the line numbering shall start
-- 		-- return the actual source code line number
-- 		line_offset = function(args)
-- 			return args.line1
-- 		end,
--
-- 		-- the distance between lines of code
-- 		line_pad = 0,
-- 		-- the rendering of tab characters as so many space characters
-- 		tab_width = 4,
-- 		-- with which language the syntax highlighting shall be done, should be
-- 		-- a function that returns either a language name or an extension like "js"
-- 		-- it is set to nil, so you can override it, if you do not set it, we try the
-- 		-- filetype first, and if that fails, the extension
-- 		-- language = nil,
-- 		language = function()
-- 			return vim.bo.filetype
-- 		end,
-- 		-- language = function()
-- 		-- 	return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":e")
-- 		-- end,
--
-- 		-- if the shadow below the os window should have be blurred
-- 		shadow_blur_radius = 16,
-- 		-- the offset of the shadow in x and y directions
-- 		shadow_offset_x = 8,
-- 		shadow_offset_y = 8,
-- 		-- the color of the shadow (in hexcode string e.g "#100808")
-- 		shadow_color = nil,
-- 		-- whether to strip of superfluous leading whitespace
-- 		gobble = true,
-- 		-- a string to pad each line with after gobbling removed larger indents,
-- 		-- num_separator = nil,
-- 		-- here a bar glyph is used to draw a vertial line and some space
-- 		num_separator = "\u{258f} ",
--
-- 		-- whether to put the image onto the clipboard, may produce an error,
-- 		-- if run on WSL2
-- 		to_clipboard = false,
-- 		-- a string or function returning a string that defines the title
-- 		-- showing in the image, only works in silicon versions greater than v0.5.1
-- 		-- window_title = nil,
-- 		-- here a function is used to get the name of the current buffer
-- 		window_title = function()
-- 			return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
-- 		end,
--
-- 		-- how to deal with the clipboard on WSL2
-- 		-- possible values are: never, always, auto
-- 		wslclipboard = nil,
-- 		-- what to do with the temporary screenshot image file when using the Windows
-- 		-- clipboard from WSL2, possible values are: keep, delete
-- 		wslclipboardcopy = nil,
-- 		-- the silicon command, put an absolute location here, if the
-- 		-- command is not in your ${PATH}
-- 		command = "silicon",
-- 		-- a string or function that defines the path to the output image
-- 		-- output = nil,
-- 		-- here a function is used to create a file in the current directory
-- 		output = function()
-- 			return "~/Pictures/Silicon" .. os.date("!%Y-%m-%dT%H-%M-%SZ") .. "_code.png"
-- 		end,
-- 	},
-- }
