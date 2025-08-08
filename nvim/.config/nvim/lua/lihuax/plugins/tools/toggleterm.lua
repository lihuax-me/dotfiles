return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			open_mapping = "<C-\\>",
			start_in_insert = true,
			direction = "float",
		})
	end,
	keys = {
		{ "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", desc = "Open floating terminal" },
		{ "<leader>th", "<cmd>ToggleTerm direction=horizontal size=6<CR>", desc = "open horizontal terminal" },
		{ "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<CR>", desc = "open vertical terminal" },
	},
}
