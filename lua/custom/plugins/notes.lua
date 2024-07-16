return {
	'RutaTang/quicknote.nvim',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		require('quicknote').setup {
			mode = 'resident', -- "portable" | "resident", default to "portable"
			sign = '', -- This is used for the signs on the left side (refer to ShowNoteSigns() api).
			filetype = 'md',
			git_branch_recognizable = true, -- If true, quicknote will separate notes by git branch
		}
	end,
}
