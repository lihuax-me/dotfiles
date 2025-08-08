return {
	"epwalsh/pomo.nvim",
	pin = true,
	--version = "*", -- Recommended, use latest release instead of latest commit
	lazy = true,
	cmd = { "TimerStart", "TimerRepeat", "TimerSession" },
	keys = {
		{ "<leader>tms", mode = { "n" }, desc = "timer session pomodoro start" },
		{ "<leader>tmh", mode = { "n" }, desc = "hide timer" },
		{ "<leader>tmd", mode = { "n" }, desc = "display timer" },
		{ "<leader>tmp", mode = { "n" }, desc = "timer pause" },
		{ "<leader>tmr", mode = { "n" }, desc = "timer resume" },
		{ "<leader>tmb", mode = { "n" }, desc = "timer break" },
	},
	dependencies = {
		-- Optional, but highly recommended if you want to use the "Default" timer
		"rcarriga/nvim-notify",
	},
	opts = {},

	config = function()
		--[[
    @Class timer
    ]]
		local PrintNotifier = {}

		PrintNotifier.new = function(timer, opts)
			local self = setmetatable({}, { __index = PrintNotifier })
			self.timer = timer
			self.hidden = false
			self.opts = opts -- not used
			return self
		end

		PrintNotifier.start = function(self)
			print(
				string.format("Starting timer #%d, %s, for %ds", self.timer.id, self.timer.name, self.timer.time_limit)
			)
		end

		PrintNotifier.tick = function(self, time_left)
			if not self.hidden then
				print(string.format("Timer #%d, %s, %ds remaining...", self.timer.id, self.timer.name, time_left))
			end
		end

		PrintNotifier.done = function(self)
			print(string.format("Timer #%d, %s, complete", self.timer.id, self.timer.name))
		end

		PrintNotifier.stop = function(self) end

		PrintNotifier.show = function(self)
			self.hidden = false
		end

		PrintNotifier.hide = function(self)
			self.hidden = true
		end

		---

		require("pomo").setup({
			init = PrintNotifier.new,
			opts = {},

			-- How often the notifiers are updated.
			update_interval = 1000,

			-- Configure the default notifiers to use for each timer.
			-- You can also configure different notifiers for timers given specific names, see
			-- the 'timers' field below.
			notifiers = {
				-- The "Default" notifier uses 'vim.notify' and works best when you have 'nvim-notify' installed.
				{
					name = "System",
					opts = {
						-- With 'nvim-notify', when 'sticky = true' you'll have a live timer pop-up
						-- continuously displayed. If you only want a pop-up notification when the timer starts
						-- and finishes, set this to false.
						sticky = true,

						-- Configure the display icons:
						title_icon = "󱎫",
						text_icon = "󰄉",
						-- Replace the above with these if you don't have a patched font:
						-- title_icon = "⏳",
						-- text_icon = "⏱️",
					},
				},

				-- The "System" notifier sends a system notification when the timer is finished.
				-- Available on MacOS and Windows natively and on Linux via the `libnotify-bin` package.
				{ name = "System" },

				-- You can also define custom notifiers by providing an "init" function instead of a name.
				-- See "Defining custom notifiers" below for an example 👇
				-- { init = function(timer) ... end }
			},

			-- Override the notifiers for specific timer names.
			timers = {
				-- For example, use only the "System" notifier when you create a timer called "Break",
				-- e.g. ':TimerStart 2m Break'.
				Break = {
					{ name = "System" },
				},
				Study = {
					{ name = "System" },
				},
				ShortBreak = {
					{ name = "System" },
				},
				LongBreak = {
					{ name = "System" },
				},
			},
			-- You can optionally define custom timer sessions.
			sessions = {
				-- Example session configuration for a session called "pomodoro".
				pomodoro = {
					{ name = "Study", duration = "45m" },
					{ name = "ShortBreak", duration = "5m" },
					{ name = "Study", duration = "35m" },
					{ name = "ShortBreak", duration = "5m" },
					{ name = "Study", duration = "45m" },
					{ name = "LongBreak", duration = "15m" },
				},
			},
		})

		local keymap = vim.keymap -- for conciseness
		keymap.set("n", "<leader>tms", "<cmd>TimerSession pomodoro<cr>", { desc = "timer session pomodoro start" })
		keymap.set("n", "<leader>tmh", "<cmd>TimerHide<cr>", { desc = "hide timer" })
		keymap.set("n", "<leader>tmd", "<cmd>TimerShow<cr>", { desc = "display timer" })
		keymap.set("n", "<leader>tmp", "<cmd>TimerPause<cr>", { desc = "timer pause" })
		keymap.set("n", "<leader>tmr", "<cmd>TimerResume<cr>", { desc = "timer resume" })
		keymap.set("n", "<leader>tmb", "<cmd>TimerStop<cr>", { desc = "timer break" })
	end,
}
