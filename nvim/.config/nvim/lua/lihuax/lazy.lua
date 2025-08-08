local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ import = "lihuax.plugins" },
	{ import = "lihuax.plugins.snacks" },
	{ import = "lihuax.plugins.common" },
	{ import = "lihuax.plugins.render" },
	{ import = "lihuax.plugins.languages" },
	{ import = "lihuax.plugins.ai" },
	{ import = "lihuax.plugins.tools" },
}, {
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})
