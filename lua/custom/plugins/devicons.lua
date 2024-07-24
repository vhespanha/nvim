return {
	{
		'nvim-tree/nvim-web-devicons',
		config = function()
			require('nvim-web-devicons').setup {
				color_icons = true,
				override_by_extension = {
					['go'] = {
						icon = '󰟓',
						color = '#58a6ff',
						name = 'Go',
					},
					['mod'] = {
						icon = '󰟓',
						color = '#ff7b72',
						name = 'Go',
					},
				},
			}
		end,
	},
	{
		'rachartier/tiny-devicons-auto-colors.nvim',
		config = function()
			require('tiny-devicons-auto-colors').setup {
				colors = {
					'#7d8590',
					'#58a6ff',
					'#3fb950',
					'#e3b341',
					'#f0883e',
					'#ff7b72',
					'#be8fff',
					'#f778ba',
					'#f78166',
				},
			}
		end,
	},
}
