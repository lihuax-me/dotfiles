require("lihuax.core")
require("lihuax.lazy")
require("lihuax.utils")

-- WARN: overwrite vim.deprecate to silence all deprecation warnings
vim.deprecate = function() end

if vim.g.neovide then
	-- Put anything you want to happen only in Neovide here
	require("lihuax.neovide")
end
