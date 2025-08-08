return {
	"glepnir/template.nvim",
	cmd = { "Template", "TemProject" },
	keys = {
		{ "<leader>tl", ":Template ", desc = "Insert template" },
	},

	config = function()
		require("template").setup({
			temp_dir = "~/.config/nvim/templates",
			author = "Lihuax",
			email = "zehuali0417@gmail.com",
		})

		local function get_weekday_date(today, n)
			-- Parse the input date string
			local year, month, day = today:match("(%d+)-(%d+)-(%d+)")
			year = tonumber(year)
			month = tonumber(month)
			day = tonumber(day)

			-- Create a date table (set to noon to avoid daylight saving time issues)
			local t = { year = year, month = month, day = day, hour = 12 }

			-- Get the timestamp and the day of the week for the input date
			local timestamp = os.time(t)
			local date_table = os.date("*t", timestamp)
			local wday = date_table.wday -- Day of the week (Sunday = 1, Saturday = 7)

			-- Calculate the difference in days between the target day and the current day
			local diff = n - wday

			-- Calculate the timestamp of the target date
			local target_timestamp = timestamp + diff * 86400 -- 86400 seconds = 1 day

			-- Get the target date table and format it as a string
			local target_date = os.date("%Y-%m-%d", target_timestamp)
			local target_month = os.date("%b", target_timestamp)
			local target_day = os.date("%A", target_timestamp)
			return string.format("[[%s/Diary_%s.md|%s]]", target_month, target_date, target_day)
		end

		-- local function get_date_days_ago(days)
		-- 	local date = os.time() - (days * 86400)
		-- 	return os.date("%Y-%m-%d", date)
		-- end

		local getWeekNumberOfYear = require("lihuax.utils.diary").getWeekNumberOfYear

		require("template").register("{{_sunday_}}", function()
			return get_weekday_date(os.date("%Y-%m-%d"), 1)
		end)

		require("template").register("{{_monday_}}", function()
			return get_weekday_date(os.date("%Y-%m-%d"), 2)
		end)

		require("template").register("{{_tuesday_}}", function()
			return get_weekday_date(os.date("%Y-%m-%d"), 3)
		end)

		require("template").register("{{_wednesday_}}", function()
			return get_weekday_date(os.date("%Y-%m-%d"), 4)
		end)

		require("template").register("{{_thursday_}}", function()
			return get_weekday_date(os.date("%Y-%m-%d"), 5)
		end)

		require("template").register("{{_friday_}}", function()
			return get_weekday_date(os.date("%Y-%m-%d"), 6)
		end)

		require("template").register("{{_saturday_}}", function()
			return get_weekday_date(os.date("%Y-%m-%d"), 7)
		end)

		require("template").register("{{_lastweeknum_}}", function()
			return getWeekNumberOfYear(os.time()) - 1
		end)
		require("template").register("{{_nextweeknum_}}", function()
			return getWeekNumberOfYear(os.time()) + 1
		end)
	end,
}
