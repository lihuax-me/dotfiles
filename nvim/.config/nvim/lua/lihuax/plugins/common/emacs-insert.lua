-- devil mode of nvim ->> emacs keybinds in insert mode
-- sorry
return {
	"assistcontrol/readline.nvim",
	config = function()
		local readline = require("readline")
		local keymap = vim.keymap

		-- move
		keymap.set("!", "<C-f>", "<Right>")
		keymap.set("!", "<C-b>", "<Left>")
		keymap.set("!", "<C-n>", "<Down>")
		keymap.set("!", "<C-p>", "<Up>")
		keymap.set("!", "<C-a>", readline.beginning_of_line)
		keymap.set("!", "<C-e>", readline.end_of_line)
		keymap.set("!", "<M-f>", readline.forward_word)
		keymap.set("!", "<M-b>", readline.backward_word)

		-- delete
		keymap.set("!", "<C-k>", readline.kill_line)
		keymap.set("!", "<C-u>", readline.backward_kill_line)
		keymap.set("!", "<M-d>", readline.kill_word)
		keymap.set("!", "<M-BS>", readline.backward_kill_word)
		keymap.set("!", "<C-w>", readline.unix_word_rubout)

		-- undo
		keymap.set("!", "<C-x>u", "<C-o>u")

		-- write and leave
		keymap.set("!", "<C-x>s", "<C-o>:w<CR>")
		keymap.set("!", "<C-x>c", "<C-o>:q<CR>")
	end,
}
