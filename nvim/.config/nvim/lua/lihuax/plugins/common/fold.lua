return {
	"kevinhwang91/nvim-ufo",
	-- event = { "BufReadPre", "BufNewFile" },
	dependencies = { "kevinhwang91/promise-async" },
	config = function()
		local handler = function(virtText, lnum, endLnum, width, truncate)
			local newVirtText = {}
			local suffix = (" 󰁂 %d "):format(endLnum - lnum)
			local sufWidth = vim.fn.strdisplaywidth(suffix)
			local targetWidth = width - sufWidth
			local curWidth = 0
			for _, chunk in ipairs(virtText) do
				local chunkText = chunk[1]
				local chunkWidth = vim.fn.strdisplaywidth(chunkText)
				if targetWidth > curWidth + chunkWidth then
					table.insert(newVirtText, chunk)
				else
					chunkText = truncate(chunkText, targetWidth - curWidth)
					local hlGroup = chunk[2]
					table.insert(newVirtText, { chunkText, hlGroup })
					chunkWidth = vim.fn.strdisplaywidth(chunkText)
					-- str width returned from truncate() may less than 2nd argument, need padding
					if curWidth + chunkWidth < targetWidth then
						suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
					end
					break
				end
				curWidth = curWidth + chunkWidth
			end
			table.insert(newVirtText, { suffix, "MoreMsg" })
			return newVirtText
		end

		vim.o.foldcolumn = "0" -- '0' is not bad
		vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true
		vim.cmd("highlight Folded guibg=none")
		--vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
		vim.o.fillchars = [[foldopen:,foldclose:]]

		local ufo = require("ufo")

		vim.keymap.set("n", "zR", ufo.openAllFolds)
		vim.keymap.set("n", "zM", ufo.closeAllFolds)
		vim.keymap.set("n", "zp", function()
			-- Try to peek folded lines under the cursor
			local winid = ufo.peekFoldedLinesUnderCursor()
			if not winid then
				-- If no folded lines, fall back to opening the fold
				ufo.openFoldsExceptKinds()
			end
		end, { desc = "Peek folded lines" })

		-- set provider

		-- 定义函数以检测 Markdown 中的 callout 块
		local function get_markdown_callout_folds(bufnr)
			local callout_folds = {}
			local line_count = vim.api.nvim_buf_line_count(bufnr)
			local is_in_callout = false
			local callout_start = 0

			for i = 0, line_count - 1 do
				local line = vim.api.nvim_buf_get_lines(bufnr, i, i + 1, false)[1]

				-- 检测以 "> [!" 开头的行，表示 callout 块的开始
				if not is_in_callout and line:match("^%s*>%s*%[!%u+%]") then
					is_in_callout = true
					callout_start = i

				-- 如果是空行或非 ">" 开头的行，则结束 callout 块
				elseif is_in_callout and (line:match("^%s*$") or not line:match("^%s*>")) then
					is_in_callout = false
					table.insert(callout_folds, { startLine = callout_start, endLine = i - 1 })
				end
			end

			-- 如果文件末尾仍处于 callout 块中，添加末尾未闭合的 callout
			if is_in_callout then
				table.insert(callout_folds, { startLine = callout_start, endLine = line_count - 1 })
			end

			return callout_folds
		end

		-- 将 Markdown 的 callout 折叠块与 Treesitter 折叠块合并
		local function treesitter_and_markdown_callout_folding(bufnr)
			local callout_folds = get_markdown_callout_folds(bufnr)
			local treesitter_folds = require("ufo").getFolds(bufnr, "treesitter")

			for _, fold in ipairs(callout_folds) do
				table.insert(treesitter_folds, fold)
			end

			return treesitter_folds
		end

		-- provider_selector = function(bufnr, filetype, buftype)
		--     if filetype == 'markdown' then
		--         return treesitter_and_markdown_callout_folding
		--     else
		--         return {'treesitter', 'indent'}
		--     end
		-- end

		require("ufo").setup({
			provider_selector = function(bufnr, filetype, buftype)
				if filetype == "markdown" then
					return treesitter_and_markdown_callout_folding
				else
					-- use treesitter as provider
					return { "treesitter", "indent" }
				end
			end,
			fold_virt_text_handler = handler,
			preview = {
				win_config = {
					border = { "", "─", "", "", "", "─", "", "" },
					winhighlight = "Normal:Normal",
					winblend = 0,
				},
				mappings = {
					scrollU = "<C-u>",
					scrollD = "<C-d>",
					jumpTop = "[",
					jumpBot = "]",
				},
			},
		})
	end,
}
