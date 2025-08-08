return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	-- event = "InsertEnter", -- disable auto load copilot to use ai less
	config = function()
		require("copilot").setup({
			suggestion = { enabled = false, auto_trigger = true },
			panel = { enabled = false },
			filetypes = {
				yaml = false,
				markdown = false,
				help = false,
				gitcommit = false,
				gitrebase = false,
				hgcommit = false,
				svn = false,
				cvs = false,
				c = false,
				cpp = false,
				rust = false,
				["."] = false,
			},
			copilot_node_command = "node", -- Node.js version must be > 18.x
			server_opts_overrides = {},
		})
	end,
}
