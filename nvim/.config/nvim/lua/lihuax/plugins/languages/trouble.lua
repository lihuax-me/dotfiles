-- tiny-inline-diagnostic nvim
local inline_opts = {
	-- Style preset for diagnostic messages
	-- Available options:
	-- "modern", "classic", "minimal", "powerline",
	-- "ghost", "simple", "nonerdfont", "amongus"
	preset = "modern",

	transparent_bg = true, -- Set the background of the diagnostic to transparent
	transparent_cursorline = false, -- Set the background of the cursorline to transparent (only one the first diagnostic)

	hi = {
		error = "DiagnosticError", -- Highlight group for error messages
		warn = "DiagnosticWarn", -- Highlight group for warning messages
		info = "DiagnosticInfo", -- Highlight group for informational messages
		hint = "DiagnosticHint", -- Highlight group for hint or suggestion messages
		arrow = "NonText", -- Highlight group for diagnostic arrows

		-- Background color for diagnostics
		-- Can be a highlight group or a hexadecimal color (#RRGGBB)
		background = "CursorLine",

		-- Color blending option for the diagnostic background
		-- Use "None" or a hexadecimal color (#RRGGBB) to blend with another color
		mixing_color = "None",
	},

	options = {
		-- Display the source of the diagnostic (e.g., basedpyright, vsserver, lua_ls etc.)
		show_source = {
			enabled = false,
			if_many = false,
		},

		-- Use icons defined in the diagnostic configuration
		use_icons_from_diagnostic = false,

		-- Set the arrow icon to the same color as the first diagnostic severity
		set_arrow_to_diag_color = false,

		-- Add messages to diagnostics when multiline diagnostics are enabled
		-- If set to false, only signs will be displayed
		add_messages = true,

		-- Time (in milliseconds) to throttle updates while moving the cursor
		-- Increase this value for better performance if your computer is slow
		-- or set to 0 for immediate updates and better visual
		throttle = 20,

		-- Minimum message length before wrapping to a new line
		softwrap = 30,

		-- Configuration for multiline diagnostics
		-- Can either be a boolean or a table with the following options:
		--  multilines = {
		--      enabled = false,
		--      always_show = false,
		-- }
		-- If it set as true, it will enable the feature with this options:
		--  multilines = {
		--      enabled = true,
		--      always_show = false,
		-- }
		multilines = {
			-- Enable multiline diagnostic messages
			enabled = false,

			-- Always show messages on all lines for multiline diagnostics
			always_show = false,

			-- Trim whitespaces from the start/end of each line
			trim_whitespaces = false,

			-- Replace tabs with spaces in multiline diagnostics
			tabstop = 4,
		},

		-- Display all diagnostic messages on the cursor line
		show_all_diags_on_cursorline = false,

		-- Enable diagnostics in Insert mode
		-- If enabled, it is better to set the `throttle` option to 0 to avoid visual artifacts
		enable_on_insert = false,

		-- Enable diagnostics in Select mode (e.g when auto inserting with Blink)
		enable_on_select = false,

		overflow = {
			-- Manage how diagnostic messages handle overflow
			-- Options:
			-- "wrap" - Split long messages into multiple lines
			-- "none" - Do not truncate messages
			-- "oneline" - Keep the message on a single line, even if it's long
			mode = "wrap",

			-- Trigger wrapping to occur this many characters earlier when mode == "wrap".
			-- Increase this value appropriately if you notice that the last few characters
			-- of wrapped diagnostics are sometimes obscured.
			padding = 0,
		},

		-- Configuration for breaking long messages into separate lines
		break_line = {
			-- Enable the feature to break messages after a specific length
			enabled = false,

			-- Number of characters after which to break the line
			after = 30,
		},

		-- Custom format function for diagnostic messages
		-- Example:
		-- format = function(diagnostic)
		--     return diagnostic.message .. " [" .. diagnostic.source .. "]"
		-- end
		format = nil,

		virt_texts = {
			-- Priority for virtual text display
			priority = 2048,
		},

		-- Filter diagnostics by severity
		-- Available severities:
		-- vim.diagnostic.severity.ERROR
		-- vim.diagnostic.severity.WARN
		-- vim.diagnostic.severity.INFO
		-- vim.diagnostic.severity.HINT
		severity = {
			vim.diagnostic.severity.ERROR,
			vim.diagnostic.severity.WARN,
			vim.diagnostic.severity.INFO,
			vim.diagnostic.severity.HINT,
		},

		-- Events to attach diagnostics to buffers
		-- You should not change this unless the plugin does not work with your configuration
		overwrite_events = nil,
	},
	disabled_ft = {}, -- List of filetypes to disable the plugin
}
local trouble_opts = {
	--focus = true,
	modes = {
		mydiags = {
			mode = "diagnostics", -- inherit from diagnostics mode
			filter = {
				any = {
					buf = 0, -- current buffer
					{
						severity = vim.diagnostic.severity.ERROR, -- errors only
						-- limit to files in the current project
						function(item)
							return item.filename:find((vim.loop or vim.uv).cwd(), 1, true)
						end,
					},
				},
			},
		},
	},
}

-- trouble nvim
return {
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
		cmd = "Trouble",
		keys = {
			{ "<leader>xw", "<cmd>Trouble diagnostics toggle<CR>", desc = "Open trouble workspace diagnostics" },
			{
				"<leader>xd",
				"<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
				desc = "Open trouble document diagnostics",
			},
			-- {
			-- 	"<leader>xx",
			-- 	"<cmd>Trouble diagnostics toggle<cr>",
			-- 	desc = "Diagnostics (Trouble)",
			-- },
			-- {
			-- 	"<leader>xX",
			-- 	"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			-- 	desc = "Buffer Diagnostics (Trouble)",
			-- },
			{ "<leader>xq", "<cmd>Trouble quickfix toggle<CR>", desc = "Open trouble quickfix list" },
			{ "<leader>xl", "<cmd>Trouble loclist toggle<CR>", desc = "Open trouble location list" },
			{ "<leader>xt", "<cmd>Trouble todo toggle<CR>", desc = "Open todos in trouble" },
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
		},
		opts = trouble_opts,
		config = function(_, opts)
			require("trouble").setup(opts)
			vim.api.nvim_set_hl(0, "TroubleNormal", { bg = "NONE" })
			vim.api.nvim_set_hl(0, "TroubleNormalNC", { bg = "NONE" })
		end,
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy", -- Or `LspAttach`
		priority = 1000, -- needs to be loaded in first
		config = function()
			require("tiny-inline-diagnostic").setup(inline_opts)
			vim.diagnostic.config({ virtual_text = false })
		end,
	},
}
