-- return {
-- 	"ekickx/clipboard-image.nvim",
-- 	pin = true,
-- 	keys = {
-- 		{ "<leader>mp", mode = { "n" } },
-- 	},
-- 	config = function()
-- 		local clipboard_image = require("clipboard-image")
--
-- 		clipboard_image.setup({
-- 			-- 配置你的图片保存路径
-- 			default = {
-- 				img_dir = "images",
-- 				img_name = function()
-- 					return os.date("%Y-%m-%d-%H-%M-%S")
-- 				end,
-- 				affix = '<img src="%s"/>', -- 可以根据 Markdown 或其他格式来更改
-- 			},
-- 			-- 可以针对不同文件类型设置不同的配置
-- 			markdown = {
-- 				img_dir = "img",
-- 				--img_name = function()
-- 				--	return vim.fn.input("Image name: ")
-- 				--end,
-- 				affix = "![](%s)", -- Markdown 格式
-- 			},
-- 		})
--
-- 		-- set keumaps
-- 		local keymap = vim.keymap
--
-- 		keymap.set("n", "<leader>mp", "<cmd>PasteImg<cr>", { desc = "paste clipboard img" })
-- 	end,
-- }
return {
	"TobinPalmer/pastify.nvim",
	cmd = { "Pastify", "PastifyAfter" },
	keys = {
		{ "<leader>mp", "<cmd>Pastify<cr>", desc = "paste image" },
	},
	config = function()
		require("pastify").setup({
			opts = {
				filename = function()
					return os.date("%Y-%m-%d-%H-%M-%S")
				end,
				local_path = "img/",
			},
			ft = {
				markdown = "![]($IMG$)",
			},
		})
	end,
}
