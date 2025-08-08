-- test if toggleterm is loaded, if not load it
local function check_toggleterm_loaded()
	if not pcall(require, "toggleterm") then
		vim.cmd("Lazy load toggleterm.nvim")
	end
end

-- use toggleterm add a term named mail
local function mail_term()
	check_toggleterm_loaded()
	local opencmd = "ToggleTerm name=mail direction=float"
	vim.cmd(opencmd)
	vim.cmd("TermExec cmd=neomutt name=mail dir=.")
end

local key = vim.api.nvim_set_keymap
local command = vim.api.nvim_create_user_command

command("Mail", function()
	mail_term()
end, { nargs = 0 })

key("n", "<leader>mm", "<cmd>Mail<CR>", { noremap = true, silent = true })
