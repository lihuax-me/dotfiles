return {
	"bngarren/checkmate.nvim",
	ft = "markdown", -- Lazy loads for Markdown files matching patterns in 'files'
	opts = {
		-- matches TODO, TODO.md, .todo.md
		files = { "diary/****/****W**.md", "diary/****/***/Diary_****-**-**.md" },
		metadata = {
			-- Example: A @priority tag that has dynamic color based on the priority value
			-- priority = {
			-- 	style = function(_value)
			-- 		local value = _value:lower()
			-- 		if value == "high" then
			-- 			return { fg = "#ff5555", bold = true }
			-- 		elseif value == "medium" then
			-- 			return { fg = "#ffb86c" }
			-- 		elseif value == "low" then
			-- 			return { fg = "#8be9fd" }
			-- 		else -- fallback
			-- 			return { fg = "#8be9fd" }
			-- 		end
			-- 	end,
			-- 	get_value = function()
			-- 		return "medium" -- Default priority
			-- 	end,
			-- 	key = "<leader>Tp",
			-- 	sort_order = 10,
			-- 	jump_to_on_insert = "value",
			-- 	select_on_insert = true,
			-- },
			-- Example: A @started tag that uses a default date/time string when added
			-- started = {
			-- 	aliases = { "init" },
			-- 	style = { fg = "#9fd6d5" },
			-- 	get_value = function()
			-- 		return tostring(os.date("%m/%d/%y %H:%M"))
			-- 	end,
			-- 	key = "<leader>Ts",
			-- 	sort_order = 20,
			-- },
			-- Example: A @done tag that also sets the todo item state when it is added and removed
			-- done = {
			-- 	aliases = { "completed", "finished" },
			-- 	style = { fg = "#96de7a" },
			-- 	get_value = function()
			-- 		return tostring(os.date("%m/%d/%y %H:%M"))
			-- 	end,
			-- 	key = "<leader>Td",
			-- 	on_add = function(todo_item)
			-- 		require("checkmate").set_todo_item(todo_item, "checked")
			-- 	end,
			-- 	on_remove = function(todo_item)
			-- 		require("checkmate").set_todo_item(todo_item, "unchecked")
			-- 	end,
			-- 	sort_order = 30,
			-- },
		},
	},
}
