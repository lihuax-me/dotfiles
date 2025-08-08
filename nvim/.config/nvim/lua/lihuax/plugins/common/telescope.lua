return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	cmd = "Telescope",
	keys = {
		{ "<leader>ff", mode = { "n" }, desc = "Fuzzy find files in cwd" },
		{ "<leader>fr", mode = { "n" }, desc = "Fuzzy find recent files" },
		{ "<leader>fs", mode = { "n" }, desc = "Find string in cwd" },
		{ "<leader>fc", mode = { "n" }, desc = "Find string under cursor in cwd" },
		{ "<leader>fb", mode = { "n" }, desc = "Fuzzy find buffers" },
		{ "<leader>ft", mode = { "n" }, desc = "Find todos" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
		"dharmx/telescope-media.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local canned = require("telescope._extensions.media.lib.canned")

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				extensions = {

					media = {
						backend = "viu", -- image/gif backend
						flags = {
							viu = {
								move = true, -- GIF preview
							},
						},
						on_confirm_single = canned.single.copy_path,
						on_confirm_muliple = canned.multiple.bulk_copy,
						-- cache_path = vim.fn.stdpath("cache") .. "/media",
					},
					mappings = {
						i = {
							["<C-k>"] = actions.move_selection_previous, -- move to prev result
							["<C-j>"] = actions.move_selection_next, -- move to next result
							["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						},
					},
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("media")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
		keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Fuzzy find buffers" })
		keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
	end,
}
