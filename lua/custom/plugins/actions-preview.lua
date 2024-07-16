return {
	'aznhe21/actions-preview.nvim',
	config = function()
		require('actions-preview').setup {
			vim.keymap.set(
				{ 'v', 'n' },
				'<Leader>ca',
				require('actions-preview').code_actions
			),
			telescope = vim.tbl_extend(
				'force',
				require('telescope.themes').get_dropdown(),
				{
					make_value = nil,
					make_make_display = nil,
				}
			),
		}
	end,
}
