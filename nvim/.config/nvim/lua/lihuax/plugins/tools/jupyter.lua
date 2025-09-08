return {
	{
		"GCBallesteros/jupytext.nvim",
		-- Depending on your nvim distro or config you may need to make the loading not lazy
		lazy = false,
		config = function()
			require("jupytext").setup({
				style = "hydrogen",
				output_extension = "auto",
				force_ft = nil,
				custom_language_formatting = {},
			})
		end,
	},
	{
		"GCBallesteros/vim-textobj-hydrogen",
		dependencies = { "kana/vim-textobj-user" },
	},
}
