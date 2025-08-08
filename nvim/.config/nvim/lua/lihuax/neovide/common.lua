-- if neovide open in scoop app dir, change to user home dir
local function set_default_dir_on_neovide()
	local current_dir = vim.fn.getcwd()
	local target_path = vim.fn.expand("F:/Program Files/Scoop/apps/neovide/current")

	local default_path = vim.fn.expand("~")

	-- 如果当前路径匹配特定路径，则切换到默认路径
	if current_dir == target_path then
		vim.api.nvim_set_current_dir(default_path)
		print("Changed directory to " .. default_path)
	end
end

set_default_dir_on_neovide()
