return {
	"b0o/incline.nvim",
	-- Optional: Lazy load Incline
	event = "VeryLazy",
	dependencies = { "nvim-web-devicons", "SmiteshP/nvim-navic" },
	config = function()
		local devicons = require("nvim-web-devicons")
		local helpers = require("incline.helpers")
		local navic = require("nvim-navic")

		require("lspconfig").clangd.setup({
			on_attach = function(client, bufnr)
				navic.attach(client, bufnr)
			end,
		})
		require("incline").setup({
			render = function(props)
				local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
				if filename == "" then
					filename = "[No Name]"
				end
				local ft_icon, ft_color = devicons.get_icon_color(filename)

				local function get_git_diff()
					local icons = { removed = " ", changed = " ", added = " " }
					local signs = vim.b[props.buf].gitsigns_status_dict
					local labels = {}
					if signs == nil then
						return labels
					end
					for name, icon in pairs(icons) do
						if tonumber(signs[name]) and signs[name] > 0 then
							table.insert(labels, { icon .. signs[name] .. " ", group = "Diff" .. name })
						end
					end
					if #labels > 0 then
						table.insert(labels, { "┊ " })
					end
					return labels
				end

				local function get_diagnostic_label()
					local icons = { error = " ", warn = " ", info = " ", hint = " " }
					local label = {}

					for severity, icon in pairs(icons) do
						local n = #vim.diagnostic.get(
							props.buf,
							{ severity = vim.diagnostic.severity[string.upper(severity)] }
						)
						if n > 0 then
							table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
						end
					end
					if #label > 0 then
						table.insert(label, { "┊ " })
					end
					return label
				end

				local modified = vim.bo[props.buf].modified
				local res = {
					ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
					" ",
					{ filename, gui = modified and "bold,italic" or "bold" },
					guibg = "#44406e",
				}
				if props.focused then
					for _, item in ipairs(navic.get_data(props.buf) or {}) do
						table.insert(res, {
							{ " > ", group = "NavicSeparator" },
							{ item.icon, group = "NavicIcons" .. item.type },
							{ item.name, group = "NavicText" },
						})
					end
				end
				table.insert(res, " ")

				return {
					{ get_diagnostic_label() },
					{ get_git_diff() },
					-- { (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" },
					-- { filename .. " ", gui = vim.bo[props.buf].modified and "bold,italic" or "bold" },
					res,
					-- { "┊ 󱂬 " .. vim.api.nvim_win_get_number(props.win), group = "DevIconWindows" },
				}
			end,
		})
	end,
}
