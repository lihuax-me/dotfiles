return {
	"smoka7/hop.nvim",
	version = "*",
	-- event = { "BufReadPre", "BufNewFile" },
	keys = {
		{ "<leader>v", desc = "Visual mode with Hop words" },
		{ "<leader>V", desc = "Visual Line mode with Hop lines" },
		-- { "<C-v>", desc = "Visual Block mode with Hop lines" },
		{ "f", desc = "Hop to character after cursor" },
		{ "F", desc = "Hop to character before cursor" },
		{ "t", desc = "Hop near character after cursor" },
		{ "T", desc = "Hop near character before cursor" },
		{ "<leader>hw", desc = "Hop to word" },
		{ "<leader>hl", desc = "Hop to line" },
	},
	opts = {
		-- keys = "etovxqpdygfbzcisuran",
		keys = "abcdegimnopqrstuvwxyz",
	},
	config = function()
		local hop = require("hop")
		hop.setup()
		local directions = require("hop.hint").HintDirection
		vim.keymap.set("", "f", function()
			hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
		end, { remap = true })
		vim.keymap.set("", "F", function()
			hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
		end, { remap = true })
		vim.keymap.set("", "t", function()
			hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
		end, { remap = true })
		vim.keymap.set("", "T", function()
			hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
		end, { remap = true })

		vim.keymap.set("", "<leader>hw", function()
			hop.hint_words()
		end, { remap = true, desc = "Hop to word" })
		vim.keymap.set("", "<leader>hl", function()
			hop.hint_lines()
		end, { remap = true, desc = "Hop to line" })

		vim.keymap.set("n", "<leader>v", function()
			vim.cmd("normal! v")
			hop.hint_words()
		end, { silent = true, desc = "Visual mode with Hop words" })

		vim.keymap.set("n", "<leader>V", function()
			vim.cmd("normal! V")
			hop.hint_lines()
		end, { silent = true, desc = "Visual Line mode with Hop lines" })

		-- BUG: <C-v> is not working
		-- vim.keymap.set("n", "<C-v>", function()
		-- 	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-v>", true, false, true), "n", true)
		-- 	hop.hint_lines()
		-- end, { silent = true, desc = "Visual Block mode with Hop words" })
	end,
}
