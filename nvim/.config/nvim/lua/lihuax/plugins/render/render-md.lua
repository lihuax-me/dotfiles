return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons", -- optional, for devicons
	},
	ft = { "markdown", "Avante" },

	-- Keymaps belong here in lazy.nvim specs
	keys = {
		{ "<leader>/", "<cmd>RenderMarkdown toggle<cr>", desc = "Render Markdown: toggle" },
	},

	-- Everything that should go into `setup()` lives in `opts`
	opts = {
		-- Disable checkbox rendering but keep list bullets as-is
		checkbox = {
			enabled = true, -- do not render [ ], [x], [-] as icons
			-- bullet = true, -- (default) keep list bullet rendering
		},

		heading = {
			-- sign = false,
			-- icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
			backgrounds = {},
		},

		backgrounds = {
			-- "Headline1Bg",
			-- "Headline2Bg",
			-- "Headline3Bg",
			-- "Headline4Bg",
			-- "Headline5Bg",
			-- "Headline6Bg",
		},
		foregrounds = {
			-- "Headline1Fg",
			-- "Headline2Fg",
			-- "Headline3Fg",
			-- "Headline4Fg",
			-- "Headline5Fg",
			-- "Headline6Fg",
		},

		-- Callouts preserved from your config
		callout = {
			note = { raw = "[!NOTE]", rendered = "󰋽 Note", highlight = "RenderMarkdownInfo" },
			tip = { raw = "[!TIP]", rendered = "󰌶 Tip", highlight = "RenderMarkdownSuccess" },
			important = { raw = "[!IMPORTANT]", rendered = "󰅾 Important", highlight = "RenderMarkdownHint" },
			warning = { raw = "[!WARNING]", rendered = "󰀪 Warning", highlight = "RenderMarkdownWarn" },
			caution = { raw = "[!CAUTION]", rendered = "󰳦 Caution", highlight = "RenderMarkdownError" },
			abstract = { raw = "[!ABSTRACT]", rendered = "󰨸 Abstract", highlight = "RenderMarkdownInfo" },
			summary = { raw = "[!SUMMARY]", rendered = "󰨸 Summary", highlight = "RenderMarkdownInfo" },
			tldr = { raw = "[!TLDR]", rendered = "󰨸 Tldr", highlight = "RenderMarkdownInfo" },
			info = { raw = "[!INFO]", rendered = "󰋽 Info", highlight = "RenderMarkdownInfo" },
			todo = { raw = "[!TODO]", rendered = "󰗡 Todo", highlight = "RenderMarkdownInfo" },
			hint = { raw = "[!HINT]", rendered = "󰌶 Hint", highlight = "RenderMarkdownSuccess" },
			success = { raw = "[!SUCCESS]", rendered = "󰄬 Success", highlight = "RenderMarkdownSuccess" },
			check = { raw = "[!CHECK]", rendered = "󰄬 Check", highlight = "RenderMarkdownSuccess" },
			done = { raw = "[!DONE]", rendered = "󰄬 Done", highlight = "RenderMarkdownSuccess" },
			question = { raw = "[!QUESTION]", rendered = "󰘥 Question", highlight = "RenderMarkdownWarn" },
			help = { raw = "[!HELP]", rendered = "󰘥 Help", highlight = "RenderMarkdownWarn" },
			faq = { raw = "[!FAQ]", rendered = "󰘥 Faq", highlight = "RenderMarkdownWarn" },
			attention = { raw = "[!ATTENTION]", rendered = "󰀪 Attention", highlight = "RenderMarkdownWarn" },
			failure = { raw = "[!FAILURE]", rendered = "󰅖 Failure", highlight = "RenderMarkdownError" },
			fail = { raw = "[!FAIL]", rendered = "󰅖 Fail", highlight = "RenderMarkdownError" },
			missing = { raw = "[!MISSING]", rendered = "󰅖 Missing", highlight = "RenderMarkdownError" },
			danger = { raw = "[!DANGER]", rendered = "󱐌 Danger", highlight = "RenderMarkdownError" },
			error = { raw = "[!ERROR]", rendered = "󱐌 Error", highlight = "RenderMarkdownError" },
			bug = { raw = "[!BUG]", rendered = "󰨰 Bug", highlight = "RenderMarkdownError" },
			example = { raw = "[!EXAMPLE]", rendered = "󰉹 Example", highlight = "RenderMarkdownHint" },
			quote = { raw = "[!QUOTE]", rendered = "󱆨 Quote", highlight = "RenderMarkdownQuote" },
			cite = { raw = "[!CITE]", rendered = "󱆨 Cite", highlight = "RenderMarkdownQuote" },
			anki = { raw = "[!ANKI]", rendered = "󰭷 Anki", highlight = "RenderMarkdownQuote" },
		},

		html = {
			-- Turn on/off all HTML rendering.
			enabled = true,
			-- Additional modes to render HTML.
			render_modes = false,
			comment = {
				conceal = false,
				text = nil,
				highlight = "RenderMarkdownHtmlComment",
			},
			tag = {
				mark = { icon = "", highlight = "" },
				u = { icon = "", highlight = "" },
			},
		},
	},

	-- Use config() only for imperative bits and to pass opts to setup()
	config = function(_, opts)
		-- Inline and HTML highlight groups
		-- (These groups are read by the plugin / your colorscheme)
		vim.api.nvim_set_hl(0, "RenderMarkdownInlineHighlight", { bg = "#444444", fg = "#ffff88", bold = true })
		vim.api.nvim_set_hl(0, "htmlHighlight", { bg = "#444444", fg = "#ffff88", bold = true })
		vim.api.nvim_set_hl(0, "htmlUnderline", { underline = true })

		require("render-markdown").setup(opts)
	end,
}
