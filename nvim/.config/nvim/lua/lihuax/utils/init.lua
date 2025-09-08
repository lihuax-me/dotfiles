require("lihuax.utils.changewd")
require("lihuax.utils.artical")
require("lihuax.utils.makeanki")
require("lihuax.utils.runner")
require("lihuax.utils.git")
require("lihuax.utils.encryption")
require("lihuax.utils.mail")
require("lihuax.utils.greek")
require("lihuax.utils.auto_update_time")
require("lihuax.utils.words")

------------------------
--- diary management ---
------------------------
local diary = require("lihuax.utils.diary")
vim.api.nvim_create_user_command("DiaryToday", diary.touch_today_diary, {})
vim.api.nvim_set_keymap("n", "<leader>dd", ":DiaryToday<CR>", { noremap = true, silent = true })
vim.api.nvim_create_user_command("DiaryWeekly", diary.touch_weekly_journal, {})
vim.api.nvim_set_keymap("n", "<leader>dw", ":DiaryWeekly<CR>", { noremap = true, silent = true })
vim.api.nvim_create_user_command("DiaryDevWeekly", diary.touch_dev_weekly_journal, {})
vim.api.nvim_set_keymap("n", "<leader>de", ":DiaryDevWeekly<CR>", { noremap = true, silent = true })

------------------------------
--- auto update management ---
------------------------------
local update_time = require("lihuax.utils.auto_update_time")
local pattern = "^updated:%s*%d%d%d%d%-%d%d%-%d%dT%d%d:%d%d"
local replacement_format = "updated: %Y-%m-%dT%H:%M:%S"
local check_lines = 8

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.md", "*.tex", "*.txt" },
	callback = function(opts)
		if vim.b._already_updating then
			return
		end
		vim.b._already_updating = true

		update_time.update_date_field(pattern, replacement_format, check_lines)

		vim.api.nvim_buf_call(opts.buf, function()
			vim.cmd("write!")
		end)

		vim.b._already_updating = false
	end,
})
