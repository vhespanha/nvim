return {
	{
		'chrisgrieser/nvim-tinygit',
		config = function()
			require('tinygit').setup {
				statusline = {
					branchState = {
						icons = {
							ahead = ' ',
							behind = ' ',
							diverge = ' ',
						},
					},
				},
			}
		end,
	},
	{ 'tpope/vim-fugitive', lazy = true },
	{
		'sindrets/diffview.nvim',
	},
}
