return {
	"smoka7/hop.nvim",
	version = "*",
	event = { "BufReadPre", "BufNewFile" },
	keys = {
		{ "v", desc = "Visual mode with Hop words" },
		{ "V", desc = "Visual Line mode with Hop lines" },
		{ "<C-v>", desc = "Visual Block mode with Hop words" },
		{ "f", desc = "Hop to character after cursor" },
		{ "F", desc = "Hop to character before cursor" },
		{ "t", desc = "Hop near character after cursor" },
		{ "T", desc = "Hop near character before cursor" },
		{ "<leader>hw", desc = "Hop to word" },
		{ "<leader>hl", desc = "Hop to line" },
	},
	config = function()
		local hop = require("hop")
		hop.setup({ keys = "ovxqdyfzcsur" })
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

		vim.keymap.set("n", "v", function()
			vim.cmd("normal! v")
			hop.hint_words()
		end, { silent = true, desc = "Visual mode with Hop words" })

		vim.keymap.set("n", "V", function()
			vim.cmd("normal! V")
			hop.hint_lines()
		end, { silent = true, desc = "Visual Line mode with Hop lines" })

		vim.keymap.set("n", "<C-v>", function()
			vim.cmd([[execute "normal! \<C-v>"]])
			hop.hint_words()
		end, { silent = true, desc = "Block visual mode with Hop words" })

		-- vim.keymap.set("x", "s", hop.hint_words, { silent = true, desc = "Hop word in visual mode" })
		-- vim.keymap.set("x", "S", hop.hint_lines, { silent = true, desc = "Hop line in visual mode" })
	end,
}
