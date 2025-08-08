local map = vim.keymap.set

-- copy and paste use ctrl/shift + insert
map("i", "<S-Insert>", "<C-R>+")
map("c", "<S-Insert>", "<C-R>+")
map("v", "<C-Insert>", '"+y')

-- change neovide scale
local function neovideScale(amount)
	local temp = vim.g.neovide_scale_factor + amount

	if temp < 0.5 then
		return
	end

	vim.g.neovide_scale_factor = temp
end

map("n", "<C-=>", function()
	neovideScale(0.1)
end)

map("n", "<C-->", function()
	neovideScale(-0.1)
end)

vim.api.nvim_set_keymap("n", "<F11>", ":let g:neovide_fullscreen = !g:neovide_fullscreen<CR>", {})
