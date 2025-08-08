--[[ return {
	"crusj/bookmarks.nvim",
	-- keys = {
	-- 	{ "<leader>bb", mode = { "n" } },
	-- },
	branch = "main",
	dependencies = { "nvim-web-devicons" },
	config = function()
		require("bookmarks").setup({
			storage_dir = "", -- Default path: vim.fn.stdpath("data").."/bookmarks,  if not the default directory, should be absolute path",
			mappings_enabled = true, -- If the value is false, only valid for global keymaps: toggle、add、delete_on_virt、show_desc
			keymap = {
				toggle = "<leader>bb", -- Toggle bookmarks(global keymap)
				close = "q", -- close bookmarks (buf keymap)
				add = "<leader>bf", -- Add bookmarks(global keymap)
				add_global = "<leader>bg", -- Add global bookmarks(global keymap), global bookmarks will appear in all projects. Identified with the symbol '󰯾'
				jump = "<CR>", -- Jump from bookmarks(buf keymap)
				delete = "dd", -- Delete bookmarks(buf keymap)
				order = "<space><space>", -- Order bookmarks by frequency or updated_time(buf keymap)
				delete_on_virt = "<leader>bd", -- Delete bookmark at virt text line(global keymap)
				show_desc = "<leader>bs", -- show bookmark desc(global keymap)
				focus_tags = "<c-j>", -- focus tags window
				focus_bookmarks = "<c-k>", -- focus bookmarks window
				toogle_focus = "<S-Tab>", -- toggle window focus (tags-window <-> bookmarks-window)
			},
			width = 0.8, -- Bookmarks window width:  (0, 1]
			height = 0.7, -- Bookmarks window height: (0, 1]
			preview_ratio = 0.45, -- Bookmarks preview window ratio (0, 1]
			tags_ratio = 0.1, -- Bookmarks tags window ratio
			fix_enable = false, -- If true, when saving the current file, if the bookmark line number of the current file changes, try to fix it.

			virt_text = "", -- Show virt text at the end of bookmarked lines, if it is empty, use the description of bookmarks instead.
			sign_icon = "󰃃", -- if it is not empty, show icon in signColumn.
			virt_pattern = { "*.go", "*.lua", "*.sh", "*.php", "*.rs" }, -- Show virt text only on matched pattern
			virt_ignore_pattern = {}, -- Ignore showing virt text on matched pattern, this works after virt_pattern
			border_style = "single", -- border style: "single", "double", "rounded"
			hl = {
				border = "TelescopeBorder", -- border highlight
				cursorline = "guibg=Gray guifg=White", -- cursorline highlight
			},
			datetime_format = "%Y-%m-%d %H:%M:%S", -- os.date
			-- •	%Y: Four-digit year
			-- •	%m: Two-digit month (01 to 12)
			-- •	%d: Two-digit day (01 to 31)
			-- •	%H: Hour in 24-hour format (00 to 23)
			-- •	%I: Hour in 12-hour format (01 to 12)
			-- •	%M: Two-digit minute (00 to 59)
			-- •	%S: Two-digit second (00 to 59)
			-- •	%p: AM/PM indicator
		})

		require("telescope").load_extension("bookmarks")
	end,
} ]]
return {
	"tomasky/bookmarks.nvim",
	keys = {
		{ "<leader>bb", mode = { "n" }, desc = "bookmarks toogle" },
		{ "<leader>bi", mode = { "n" }, desc = "edit mark annotation" },
		{ "<leader>bc", mode = { "n" }, desc = "clean all markrs in buffer" },
		{ "<leader>bn", mode = { "n" }, desc = "next mark in  buffer" },
		{ "<leader>bp", mode = { "n" }, desc = "previous mark in buffer" },
		{ "<leader>bl", mode = { "n" }, desc = "show bookmark list" },
		{ "<leader>bx", mode = { "n" }, desc = "remove all bookmarks" },
	},
	config = function()
		require("bookmarks").setup({
			-- sign_priority = 8, --set bookmark sign priority to cover other sign
			save_file = vim.fn.expand("~/.config/nvim/bookmarks"), -- bookmarks save file path
			keywords = {
				["@t"] = "", -- mark annotation startswith @t ,signs this icon as `Todo`
				["@w"] = "", -- mark annotation startswith @w ,signs this icon as `Warn`
				["@f"] = "", -- mark annotation startswith @f ,signs this icon as `Fix`
				["@n"] = "󱝽", -- mark annotation startswith @n ,signs this icon as `Note`
			},
			on_attach = function(bufnr)
				local bm = require("bookmarks")
				local keymap = vim.keymap
				keymap.set("n", "<leader>bb", bm.bookmark_toggle, { desc = "bookmarks toogle" }) -- add or remove bookmark at current line
				keymap.set("n", "<leader>bi", bm.bookmark_ann, { desc = "edit mark annotation" }) -- add or edit mark annotation at current line
				keymap.set("n", "<leader>bc", bm.bookmark_clean, { desc = "clean all markrs in buffer" }) -- clean all marks in local buffer
				keymap.set("n", "<leader>bn", bm.bookmark_next, { desc = "next mark in  buffer" }) -- jump to next mark in local buffer
				keymap.set("n", "<leader>bp", bm.bookmark_prev, { desc = "previous mark in buffer" }) -- jump to previous mark in local buffer
				keymap.set("n", "<leader>bl", bm.bookmark_list, { desc = "show bookmark list" }) -- show marked file list in quickfix window
				keymap.set("n", "<leader>bx", bm.bookmark_clear_all, { desc = "remove all bookmarks" }) -- removes all bookmarks
			end,
			vim.keymap.set("n", "<leader>fm", "<cmd>Telescope bookmarks list<cr>", { desc = "Find bookmarks" }),
			sign_priority = 8,
		})
		require("telescope").load_extension("bookmarks")
	end,
}
