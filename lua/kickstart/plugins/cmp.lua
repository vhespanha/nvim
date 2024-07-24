return {
	{ -- Autocompletion
		'hrsh7th/nvim-cmp',
		event = 'InsertEnter',
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			{
				'L3MON4D3/LuaSnip',
				build = (function()
					-- Build Step is needed for regex support in snippets.
					-- This step is not supported in many windows environments.
					-- Remove the below condition to re-enable on windows.
					if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
						return
					end
					return 'make install_jsregexp'
				end)(),
				dependencies = {
					-- `friendly-snippets` contains a variety of premade snippets.
					--    See the README about individual language/framework/plugin snippets:
					--    https://github.com/rafamadriz/friendly-snippets
					{
						'rafamadriz/friendly-snippets',
						config = function()
							require('luasnip.loaders.from_vscode').lazy_load()
						end,
					},
				},
			},
			'saadparwaiz1/cmp_luasnip',

			-- Adds other completion capabilities.
			--  nvim-cmp does not ship with all sources by default. They are split
			--  into multiple repos for maintenance purposes.
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-path',
		},
		config = function()
			-- See `:help cmp`
			local cmp = require 'cmp'
			local luasnip = require 'luasnip'
			luasnip.config.setup {}

			local has_words_before = function()
				if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then
					return false
				end
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api
							.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]
							:match '^%s*$'
						== nil
			end

			cmp.setup {
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				sorting = {
					priority_weight = 2,
					comparators = {
						require('copilot_cmp.comparators').prioritize,
						-- Below is the default comparitor list and order for nvim-cmp
						cmp.config.compare.offset,
						-- cmp.config.compare.scopes, --this is commented in nvim-cmp too
						cmp.config.compare.exact,
						cmp.config.compare.score,
						cmp.config.compare.recently_used,
						cmp.config.compare.locality,
						cmp.config.compare.kind,
						cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
					},
				},
				completion = { completeopt = 'menu,menuone,noinsert' },

				window = {
					completion = cmp.config.window.bordered {
						winhighlight = 'Normal:Pmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None',
					},
					documentation = cmp.config.window.bordered {
						winhighlight = 'Normal:Pmenu,FloatBorder:CmpDocBorder,CursorLine:PmenuSel,Search:None',
					},
				},
				vim.api.nvim_set_hl(0, 'CmpBorder', { fg = '#272727', bg = '#0f0f0f' }),
				vim.api.nvim_set_hl(0, 'CmpDocBorder', { fg = '#272727', bg = '#0f0f0f' }),
				vim.api.nvim_set_hl(0, 'PmenuSel', { bg = '#272727' }),
				vim.api.nvim_set_hl(0, 'Pmenu', { fg = '#272727', bg = '#0f0f0f' }),

				-- For an understanding of why these mappings were
				-- chosen, you will need to read `:help ins-completion`
				--
				-- No, but seriously. Please read `:help ins-completion`, it is really good!
				mapping = cmp.mapping.preset.insert {
					-- Select the [n]ext item
					['<Down>'] = cmp.mapping.select_next_item(),
					-- Select the [p]revious item
					['<Up>'] = cmp.mapping.select_prev_item(),
					-- Scroll the documentation window [b]ack / [f]orward
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),

					-- Accept ([y]es) the completion.
					--  This will auto-import if your LSP supports it.
					--  This will expand snippets if the LSP sent a snippet.
					-- ['<C-y>'] = cmp.mapping.confirm { select = true },

					-- If you prefer more traditional completion keymaps,
					-- you can uncomment the following lines
					['<Tab>'] = cmp.mapping.confirm { select = true },

					-- Manually trigger a completion from nvim-cmp.
					--  Generally you don't need this, because nvim-cmp will display
					--  completions whenever it has completion options available.
					['<C-Space>'] = cmp.mapping.complete {},
					-- Think of <c-l> as moving to the right of your snippet expansion.
					--  So if you have a snippet that's like:
					--  function $name($args)
					--    $body
					--  end
					--
					-- <c-l> will move you to the right of each of the expansion locations.
					-- <c-h> is similar, except moving you backwards.
					['<C-l>'] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { 'i', 's' }),
					['<C-h>'] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { 'i', 's' }),

					-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
					--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
				},
				sources = {
					{ name = 'copilot', group_index = 2 },
					{ name = 'nvim_lsp', group_index = 2 },
					{ name = 'path', group_index = 2 },
					{ name = 'luasnip', group_index = 2 },
				},
			}
		end,
	},
}
-- vim: ts=2 sts=2 sw=2 et
