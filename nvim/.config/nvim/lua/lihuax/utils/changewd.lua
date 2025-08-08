-- Function to change the current working directory to the file's directory
function ChangeToCurrentFileDirectory()
	local file_dir = vim.fn.expand("%:p:h") -- Get the current file's directory
	if file_dir ~= "" then
		vim.cmd("cd " .. file_dir) -- Change the working directory
		print("Changed working directory to: " .. file_dir)
	else
		print("No file found or buffer is empty")
	end
end

-- Create a command to call the function
vim.api.nvim_create_user_command("ChangeCwdToFile", ChangeToCurrentFileDirectory, {})
vim.api.nvim_set_keymap("n", "<leader>cd", ":ChangeCwdToFile<CR>", { noremap = true, silent = true })
