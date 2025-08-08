-- a tool to quick qick greek letter and input

local chars = {
	{ name = "Alpha", char = "Α" },
	{ name = "alpha", char = "α" },
	{ name = "Beta", char = "Β" },
	{ name = "beta", char = "β" },
	{ name = "Gamma", char = "Γ" },
	{ name = "gamma", char = "γ" },
	{ name = "Delta", char = "Δ" },
	{ name = "delta", char = "δ" },
	{ name = "Epsilon", char = "Ε" },
	{ name = "epsilon", char = "ε" },
	{ name = "Zeta", char = "Ζ" },
	{ name = "zeta", char = "ζ" },
	{ name = "Eta", char = "Η" },
	{ name = "eta", char = "η" },
	{ name = "Theta", char = "Θ" },
	{ name = "theta", char = "θ" },
	{ name = "Iota", char = "Ι" },
	{ name = "iota", char = "ι" },
	{ name = "Kappa", char = "Κ" },
	{ name = "kappa", char = "κ" },
	{ name = "Lambda", char = "Λ" },
	{ name = "lambda", char = "λ" },
	{ name = "Mu", char = "Μ" },
	{ name = "mu", char = "μ" },
	{ name = "Nu", char = "Ν" },
	{ name = "nu", char = "ν" },
	{ name = "Xi", char = "Ξ" },
	{ name = "xi", char = "ξ" },
	{ name = "Omicron", char = "Ο" },
	{ name = "omicron", char = "ο" },
	{ name = "Pi", char = "Π" },
	{ name = "pi", char = "π" },
	{ name = "Rho", char = "Ρ" },
	{ name = "rho", char = "ρ" },
	{ name = "Sigma", char = "Σ" },
	{ name = "sigma", char = "σ" },
	{ name = "Tau", char = "Τ" },
	{ name = "tau", char = "τ" },
	{ name = "Upsilon", char = "Υ" },
	{ name = "upsilon", char = "υ" },
	{ name = "Phi", char = "Φ" },
	{ name = "phi", char = "φ" },
	{ name = "Chi", char = "Χ" },
	{ name = "chi", char = "χ" },
	{ name = "Psi", char = "Ψ" },
	{ name = "psi", char = "ψ" },
	{ name = "Omega", char = "Ω" },
	{ name = "omega", char = "ω" },
}

local function pick()
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	pickers
		.new({}, {
			prompt_title = "Insert Symbol",
			finder = finders.new_table({
				results = chars,
				entry_maker = function(entry)
					return {
						value = entry,
						display = entry.char .. " - " .. entry.name,
						ordinal = entry.name,
					}
				end,
			}),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					if selection then
						vim.api.nvim_put({ selection.value.char }, "c", true, true)
					end
				end)
				return true
			end,
		})
		:find()
end

local key = vim.api.nvim_set_keymap
local command = vim.api.nvim_create_user_command

command("Greek", function()
	pick()
end, { nargs = 0 })

key("n", "<leader>gi", "<cmd>Greek<CR>", { desc = "Insert Greek letters" })

vim.keymap.set("i", "<C-g>", function()
	vim.cmd("stopinsert")
	vim.schedule(function()
		pick()
		vim.cmd("startinsert")
	end)
end, { desc = "Insert Greek letter in Insert Mode" })
