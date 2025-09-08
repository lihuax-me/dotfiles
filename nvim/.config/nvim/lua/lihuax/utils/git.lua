-- git_commit_composer.lua
-- Run commit_composer at git repo root using toggleterm (float window)

local Snacks = require("snacks")

local function ensure_toggleterm()
	if not pcall(require, "toggleterm") then
		vim.cmd("Lazy load toggleterm.nvim") -- adjust for your plugin manager
	end
end

local function get_git_root()
	if not (Snacks and Snacks.git and Snacks.git.get_root) then
		vim.notify("[git-cc] Snacks.git.get_root() not available", vim.log.levels.ERROR)
		return nil
	end
	local root = Snacks.git.get_root()
	if root == nil or root == "" then
		return nil
	end
	return root
end

local function run_commit_composer()
	ensure_toggleterm()
	local root = get_git_root()
	if not root then
		vim.notify("[git-cc] Not inside a git repository", vim.log.levels.WARN)
		return
	end

	vim.cmd('ToggleTerm name="commit_composer" direction=float')
	vim.cmd('TermExec cmd="commit_composer" name="commit_composer" dir=' .. root)
end

vim.api.nvim_create_user_command("CommitComposer", run_commit_composer, {
	desc = "Run commit_composer at repo root in a floating terminal",
})

-- optional keymap
vim.keymap.set("n", "<leader>gc", run_commit_composer, { desc = "Commit Composer (git root)" })
