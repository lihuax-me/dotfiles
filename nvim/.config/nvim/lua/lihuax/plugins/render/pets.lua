return {
	"ApoorvShah/pets.nvim",
	cmd = { "PetsNew", "PetsNewCustom" },
	dependencies = { "MunifTanjim/nui.nvim", "giusgad/hologram.nvim" },
	keys = {
		{
			"<leader>pn",
			"<cmd>PetsNew pet<cr>",
			desc = "Spawn a new pet",
		},
	},
	config = function()
		require("pets").setup({
			row = 4,
			col = 25,
			speed_multiplier = 1,
			default_pet = "cat",
			default_style = "light_gray",
			random = false,
			death_animation = true,
			popup = {
				width = "30%",
				winblend = 100,
				hl = { Normal = "Normal" },
				avoid_statusline = false,
			},
		})
	end,
}
