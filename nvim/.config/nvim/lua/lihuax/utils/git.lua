-- Git Utilities for Floating Terminals in Neovim

local Snacks = require("snacks")
local Terminal = require("toggleterm.terminal").Terminal

local M = {}

-----------------------------------------------------------
-- Ensure `toggleterm.nvim` is loaded
-----------------------------------------------------------
function M.ensure_toggleterm()
	if not pcall(require, "toggleterm") then
		vim.cmd("Lazy load toggleterm.nvim") -- Adjust for your plugin manager
	end
end

-----------------------------------------------------------
-- Get the root directory of the current git repository
-----------------------------------------------------------
function M.get_git_root()
	if not (Snacks and Snacks.git and Snacks.git.get_root) then
		vim.notify("[git-utils] Snacks.git.get_root() not available", vim.log.levels.ERROR)
		return nil
	end

	local root = Snacks.git.get_root()
	if root == nil or root == "" then
		-- vim.notify("[git-utils] Not inside a git repository", vim.log.levels.WARN)
		return nil
	end

	return root
end

-----------------------------------------------------------
-- Create a floating terminal with optional command and size
-- @param cmd: command to run in the terminal
-- @param width_ratio: terminal width relative to screen (0-1)
-- @param height_ratio: terminal height relative to screen (0-1)
-- @return: Terminal instance
-----------------------------------------------------------
function M.create_git_float(cmd, width_ratio, height_ratio)
	M.ensure_toggleterm()
	local root = M.get_git_root()
	if not root then
		return
	end

	width_ratio = width_ratio or 0.5
	height_ratio = height_ratio or 0.5

	local term = Terminal:new({
		cmd = cmd,
		dir = root,
		direction = "float",
		float_opts = {
			border = "curved",
			width = math.floor(vim.o.columns * width_ratio),
			height = math.floor(vim.o.lines * height_ratio),
		},
		hidden = true,
	})

	return term
end

-----------------------------------------------------------
-- GH Dash: Open GitHub dashboard in floating terminal
-----------------------------------------------------------
local gh_dash_term = M.create_git_float("gh dash", 0.9, 0.9)

local function run_gh_dash()
	local root = M.get_git_root()
	if not root then
		return
	end
	gh_dash_term.dir = root -- refresh working directory
	gh_dash_term:toggle()
end

vim.api.nvim_create_user_command("GhDash", run_gh_dash, {
	desc = "Run GH Dash at repo root in a floating terminal",
})

vim.keymap.set("n", "<leader>Gh", run_gh_dash, { desc = "Open GH Dash (git root)" })

-----------------------------------------------------------
-- Commit Composer: Open commit composer in floating terminal
-----------------------------------------------------------
local commit_term = M.create_git_float("commit_composer", 0.35, 0.35)

local function run_commit_composer()
	local root = M.get_git_root()
	if not root then
		return
	end
	commit_term.dir = root
	commit_term:toggle()
end

vim.api.nvim_create_user_command("CommitComposer", run_commit_composer, {
	desc = "Run commit_composer at repo root in a floating terminal",
})

vim.keymap.set("n", "<leader>Gc", run_commit_composer, { desc = "Open Commit Composer (git root)" })

-----------------------------------------------------------
-- Stage files as empty commit in floating terminal
-----------------------------------------------------------
local stage_as_empty_term = M.create_git_float("stage_as_empty", 0.35, 0.65)

local function run_stage_as_empty()
	local root = M.get_git_root()
	if not root then
		return
	end
	stage_as_empty_term.dir = root
	stage_as_empty_term:toggle()
end

vim.api.nvim_create_user_command("StageAsEmpty", run_stage_as_empty, {
	desc = "Run stage_as_empty at repo root in a floating terminal",
})

vim.keymap.set("n", "<leader>Gs", run_stage_as_empty, {
	desc = "Stage files as empty commit (git root)",
})

-----------------------------------------------------------
-- Select Git user in floating terminal
-----------------------------------------------------------
local select_git_user_term = M.create_git_float("select_git_user", 0.20, 0.65)

local function run_select_git_user()
	local root = M.get_git_root()
	if not root then
		return
	end
	select_git_user_term.dir = root
	select_git_user_term:toggle()
end

vim.api.nvim_create_user_command("SelectGitUser", run_select_git_user, {
	desc = "Run select_git_user at repo root in a floating terminal",
})

vim.keymap.set("n", "<leader>Gu", run_select_git_user, {
	desc = "Select Git user (git root)",
})
