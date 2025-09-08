--- Encrypts the current file using GPG
-- Encrypts the file with the specified recipient and replaces the original file with the encrypted version
-- Shows appropriate notifications for success/failure
local function encrypt_file()
	local file_path = vim.fn.expand("%:p") -- Get full path of current file
	if file_path == "" then
		vim.notify("No file to encrypt!", vim.log.levels.WARN)
		return
	end

	-- Format GPG encryption command
	local gpg_command =
		string.format('gpg --yes --encrypt --recipient "zehuali0417@gmail" --output %s.gpg %s', file_path, file_path)
	local delete_command = string.format("rm -f %s", file_path)

	vim.cmd("write") -- Save current file before encryption
	vim.fn.system(gpg_command) -- Execute GPG encryption

	if vim.v.shell_error == 0 then
		vim.fn.system(delete_command) -- Delete original file after successful encryption
		vim.cmd("e " .. file_path .. ".gpg") -- Open the encrypted file
		vim.notify("File encrypted successfully!", vim.log.levels.INFO)
	else
		vim.notify("Encryption failed!", vim.log.levels.ERROR)
	end
end

--- Decrypts a GPG encrypted file
-- Decrypts the current .gpg file and opens the decrypted version
-- Shows appropriate notifications for success/failure
local function decrypt_file()
	local file_path = vim.fn.expand("%:p") -- Get full path of current file
	if not file_path:match("%.gpg$") then
		vim.notify("Not a GPG encrypted file!", vim.log.levels.WARN)
		return
	end

	local output_file = file_path:gsub("%.gpg$", "") -- Remove .gpg extension for output
	local gpg_command = string.format("gpg --yes --output %s --decrypt %s", output_file, file_path)

	vim.fn.system(gpg_command) -- Execute GPG decryption

	-- Exit code 0 or 2 are considered successful (2 allows for non-critical warnings)
	if vim.v.shell_error == 0 or vim.v.shell_error == 2 then
		vim.cmd("e " .. output_file) -- Open the decrypted file
		vim.notify("File decrypted successfully!", vim.log.levels.INFO)
	else
		vim.notify("Decryption failed!", vim.log.levels.ERROR)
	end
end

-- Create user commands and key mappings
local key = vim.api.nvim_set_keymap
local command = vim.api.nvim_create_user_command

-- Register global commands for encryption/decryption
command("EncryptFile", encrypt_file, {})
command("DecryptFile", decrypt_file, {})

-- Set key mappings for quick access
key("n", "<leader>ce", ":EncryptFile<CR>", { noremap = true, silent = true })
key("n", "<leader>cd", ":DecryptFile<CR>", { noremap = true, silent = true })
