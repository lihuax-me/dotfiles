-- define common options
local opts = {
	noremap = true, -- non-recursive
	silent = true, -- do not show message
}
local keymap = vim.keymap -- for conciseness

-- set leader key to space
vim.g.mapleader = " "

-----------------
-- Normal mode --
-----------------

keymap.set("n", "<leader>w", "<cmd>w!<CR>", { desc = "Forcee Write" })
keymap.set("n", "<leader>rr", "<cmd>e!<CR>", { desc = "Forcee Reload" })

-- local function search_sentence(forward)
-- 	local pattern = "[.!?]\\|</u>\\|</span>\\|</p>"
-- 	local cmd = forward and "/" .. pattern .. "/e" or "?" .. pattern .. "/e"
-- 	vim.cmd("silent! normal! " .. cmd .. "\r")
-- 	vim.cmd("nohlsearch")
-- end
-- keymap.set("n", ")", function()
-- 	search_sentence(true)
-- end, { noremap = true })
-- keymap.set("n", "(", function()
-- 	search_sentence(false)
-- end, { noremap = true })

-- Hint: see `:h vim.map.set()`
-- Better window navigation
keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Windows position exchange
keymap.set("n", "<C-w>h", "<cmd>wincmd H<CR>", opts)
keymap.set("n", "<C-w>j", "<cmd>wincmd J<CR>", opts)
keymap.set("n", "<C-w>k", "<cmd>wincmd K<CR>", opts)
keymap.set("n", "<C-w>l", "<cmd>wincmd L<CR>", opts)
keymap.set("n", "<C-w>r", "<cmd>wincmd r<CR>", opts)

-- Resize with arrows
-- delta: 2 lines
keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- switch between buffers use alt + j/k
keymap.set("n", "<C-s>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
keymap.set("n", "<C-d>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
-- vim.api.nvim_set_keymap("n", "<A-j>", ":bnext<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<A-k>", ":bprev<CR>", { noremap = true, silent = true })

keymap.set("n", "<leader>aw", "<cmd>set wrap!<CR>", { desc = "toggle wrap" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights", silent = true })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-----------------
-- Visual mode --
-----------------

-- 句子跳转
-- keymap.set("v", ")", function()
-- 	search_sentence(true)
-- end, { noremap = true })
-- keymap.set("v", "(", function()
-- 	search_sentence(false)
-- end, { noremap = true })
-- keymap.set("v", ")", "/[.!?]\\|</u\\.>\\|</span>\\|</p>/e<CR>", { silent = true })
-- keymap.set("v", "(", "?[.!?]\\|</u\\.>\\|</span>\\|</p>/e<CR>", { silent = true })

-- Hint: start visual mode with the same area as the previous area and the same mode
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

---------------------------
-- Operator pending mode --
---------------------------

-- keymap.set({ "o", "x" }, "i)", function()
-- 	search_sentence(true)
-- end, { noremap = true })
-- keymap.set({ "o", "x" }, "i(", function()
-- 	search_sentence(false)
-- end, { noremap = true })

----------------
--- terminal ---
----------------

keymap.set("t", "<Esc>", "<C-\\><C-n>", opts) -- exit terminal mode
