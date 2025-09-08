return {
	"saghen/blink.cmp",
	version = "1.*",
	event = "InsertEnter",
	dependencies = {
		-- Snippets
		{ "L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp" },
		"rafamadriz/friendly-snippets",
		-- Copilot as a completion source (not ghost-text)
		"giuxtaposition/blink-cmp-copilot",
		-- Spell source for blink
		"ribru17/blink-cmp-spell",
	},

	-- If you also load "hrsh7th/nvim-cmp" somewhere else, make sure to disable it there.

	config = function()
		-- ===== spell settings (same as your original) =====
		vim.opt.spell = true
		vim.opt.spelllang = { "en_us" }

		-- ===== blink.cmp =====
		local cmp = require("blink.cmp")

		cmp.setup({
			-- Use LuaSnip integration
			snippets = { preset = "luasnip" },

			-- Auto-popup on text change (rough equivalent of your cmp TriggerEvent.TextChanged)
			completion = {
				menu = { auto_show = true },
				documentation = { auto_show = true, auto_show_delay_ms = 200 },
				ghost_text = { enabled = true },
				-- Do not preselect to mirror your `confirm({ select = true })` + manual nav feel
				list = { selection = { preselect = false, auto_insert = false } },
			},

			-- Keymaps: emulate your mappings closely
			keymap = (function()
				-- Start from the 'enter' preset so <CR> accepts, then override specifics.
				local km = { preset = "enter" }
				-- Navigation like your <C-j>/<C-k>
				km["<C-j>"] = { "select_next", "fallback" }
				km["<C-k>"] = { "select_prev", "fallback" }
				-- Docs scroll like your <C-f>/<C-b>
				km["<A-f>"] = { "scroll_documentation_down", "fallback" }
				km["<A-b>"] = { "scroll_documentation_up", "fallback" }
				-- Super-Tab behavior: select->snippet->show->fallback
				km["<Tab>"] = {
					function(c)
						if c.snippet_active() then
							return c.snippet_forward()
						end
					end,
					"select_next",
					"show",
					"fallback",
				}
				km["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" }
				km["<C-n>"] = false
				km["<C-p>"] = false
				return km
			end)(),

			-- Sources: order mirrors your setup; add copilot & spell
			sources = {
				default = { "snippets", "lsp", "buffer", "path", "copilot", "spell" },
				per_filetype = {
					markdown = { "buffer", "path", "snippets", "lsp", "copilot", "spell" },
					text = { "buffer", "path", "snippets", "lsp", "copilot", "spell" },
					gitcommit = { "buffer", "path", "snippets", "lsp", "copilot", "spell" },
				},
				providers = {
					-- Copilot source (requires zbirenbaum/copilot.lua configured elsewhere)
					copilot = {
						name = "copilot",
						module = "blink-cmp-copilot",
						async = true,
						-- Slightly boost Copilot so it shows near the top but not above exact LSP hits
						score_offset = 80,
						-- Optional: mark items as "Copilot" kind and add an icon
						transform_items = function(_, items)
							local K = require("blink.cmp.types").CompletionItemKind
							local idx = #K + 1
							K[idx] = "Copilot"
							for _, it in ipairs(items) do
								it.kind = idx
							end
							return items
						end,
					},
					-- Spell source
					spell = {
						name = "Spell",
						module = "blink-cmp-spell",
						opts = {
							-- Only offer when `spell` is active and word length >= 2
							min_keyword_length = 2,
						},
						-- Lower noise in code buffers by keeping spell as a normal item
						score_offset = -10,
					},
				},
			},

			-- Appearance: supply a Copilot icon (others keep defaults)
			appearance = {
				kind_icons = {
					Copilot = " ",
				},
			},
		})

		-- Optional: load friendly-snippets for LuaSnip
		require("luasnip.loaders.from_vscode").lazy_load()

		-- If you use lspconfig, ensure capabilities are updated for blink
		-- (Neovim 0.11+ may not need this, but it's harmless.)
		local ok, lspconfig = pcall(require, "lspconfig")
		if ok then
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			-- Example: apply to some servers you use
			-- lspconfig.lua_ls.setup({ capabilities = capabilities })
			-- lspconfig.pyright.setup({ capabilities = capabilities })
			-- ...
		end
	end,
}

-- return {
-- 	"hrsh7th/nvim-cmp",
-- 	event = "InsertEnter",
-- 	dependencies = {
-- 		"hrsh7th/cmp-buffer",
-- 		"hrsh7th/cmp-path",
-- 		{
-- 			"L3MON4D3/LuaSnip",
-- 			version = "v2.*",
-- 			build = "make install_jsregexp",
-- 		},
-- 		"saadparwaiz1/cmp_luasnip",
-- 		"rafamadriz/friendly-snippets",
-- 		"onsails/lspkind.nvim",
-- 		"f3fora/cmp-spell",
-- 	},
--
-- 	config = function()
-- 		-- ===== helpers =====
-- 		local has_words_before = function()
-- 			unpack = unpack or table.unpack
-- 			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
-- 			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- 		end
--
-- 		-- ===== require =====
-- 		local cmp = require("cmp")
-- 		local luasnip = require("luasnip")
-- 		local lspkind = require("lspkind")
--
-- 		-- ===== spell settings =====
-- 		-- Global spell; adjust languages to your needs.
-- 		vim.opt.spell = true
-- 		vim.opt.spelllang = { "en_us" } -- e.g. {"en_us","en_gb"}
--
-- 		-- ===== core cmp =====
-- 		cmp.setup({
-- 			snippet = {
-- 				expand = function(args)
-- 					luasnip.lsp_expand(args.body)
-- 				end,
-- 			},
--
-- 			-- Auto-popup on text change
-- 			completion = {
-- 				autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
-- 			},
--
-- 			mapping = cmp.mapping.preset.insert({
-- 				["<C-b>"] = cmp.mapping.scroll_docs(-4),
-- 				["<C-f>"] = cmp.mapping.scroll_docs(4),
-- 				["<C-k>"] = cmp.mapping.select_prev_item(),
-- 				["<C-j>"] = cmp.mapping.select_next_item(),
-- 				["<CR>"] = cmp.mapping.confirm({ select = true }),
--
-- 				["<C-n>"] = cmp.config.disable,
-- 				["<C-p>"] = cmp.config.disable,
--
-- 				["<Tab>"] = cmp.mapping(function(fallback)
-- 					if cmp.visible() then
-- 						cmp.select_next_item()
-- 					elseif has_words_before() then
-- 						cmp.complete()
-- 					else
-- 						fallback()
-- 					end
-- 				end, { "i", "s" }),
--
-- 				["<S-Tab>"] = cmp.mapping(function(fallback)
-- 					if cmp.visible() then
-- 						cmp.select_prev_item()
-- 					elseif luasnip.jumpable(-1) then
-- 						luasnip.jump(-1)
-- 					else
-- 						fallback()
-- 					end
-- 				end, { "i", "s" }),
-- 			}),
--
-- 			formatting = {
-- 				format = lspkind.cmp_format({
-- 					maxwidth = 50,
-- 					ellipsis_char = "...",
-- 				}),
-- 			},
--
-- 			-- Default sources for general (code-like) buffers:
-- 			-- Keep spell lower to reduce noise while coding.
-- 			sources = cmp.config.sources({
-- 				{ name = "copilot" },
-- 				{ name = "nvim_lsp" },
-- 				{ name = "luasnip" },
-- 				{
-- 					name = "buffer",
-- 					option = {
-- 						-- complete from all open buffers
-- 						get_bufnrs = function()
-- 							return vim.api.nvim_list_bufs()
-- 						end,
-- 					},
-- 				},
-- 				{ name = "path" },
-- 				{ name = "spell", keyword_length = 2 },
-- 			}),
-- 		})
--
-- 		-- Text-centric filetypes: prioritize spell higher
-- 		local text_like = { "markdown", "text", "gitcommit" }
-- 		for _, ft in ipairs(text_like) do
-- 			cmp.setup.filetype(ft, {
-- 				sources = cmp.config.sources({
-- 					{ name = "buffer" },
-- 					{ name = "path" },
-- 					{ name = "luasnip" },
-- 					{ name = "nvim_lsp" },
-- 					{ name = "copilot" },
-- 					{ name = "spell", keyword_length = 2 },
-- 				}),
-- 			})
-- 		end
--
-- 		-- Icons (optional)
-- 		lspkind.init({
-- 			symbol_map = {
-- 				Copilot = " ",
-- 			},
-- 		})
-- 	end,
-- }
