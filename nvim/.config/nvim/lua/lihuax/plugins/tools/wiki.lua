return {
	"renerocksai/telekasten.nvim",
	dependencies = { "nvim-telescope/telescope.nvim" },
	ft = { "markdown" },
	-- keys = {
	-- 	{ "<leader>fl", mode = { "n" }, desc = "Find wiki links" },
	-- 	{ "<leader>fi", mode = { "n" }, desc = "Find wiki links" },
	-- },
	config = function()
		require("telekasten").setup({
			home = vim.fn.expand("~/Documents/notes"),
			auto_set_filetype = false,
			-- vim.api.nvim_set_hl(0, "tkLink", {
			-- 	ctermfg = "blue",
			-- 	cterm = { "bold", "underline" },
			-- 	guifg = "blue",
			-- 	gui = { "bold", "underline" },
			-- }),
			-- vim.api.nvim_set_hl(0, "tkBrackets", {
			-- 	ctermfg = "gray",
			-- 	guifg = "gray",
			-- }),
		})
		vim.keymap.set("n", "<leader>fl", "<cmd>Telekasten follow_link<cr>", { desc = "Find wiki links" })
		vim.keymap.set("n", "<leader>fi", "<cmd>Telekasten insert_link<cr>", { desc = "Find and Insert wiki links" })
	end,
}
