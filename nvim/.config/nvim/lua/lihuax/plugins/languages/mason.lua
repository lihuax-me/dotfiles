return {
	"williamboman/mason.nvim",
	cmd = { "Mason" },
	ft = { "c", "cpp", "java", "lua", "perl", "python", "rust", "sql", "markdown", "julia", "tex", "go" },
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		-- local mason_lspconfig = require("mason-lspconfig")
		-- local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})
	end,
}
