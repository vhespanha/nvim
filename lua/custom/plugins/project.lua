return {
	'webmandman/project.nvim',
	config = function()
		require('project_nvim').setup {
			manual_mode = false,
			detection_methods = { 'lsp', 'pattern' },
			patterns = {
				'.git',
				'_darcs',
				'.hg',
				'.bzr',
				'.svn',
				'Makefile',
				'package.json',
			},
			ignore_lsp = {},
			exclude_dirs = {},
			show_hidden = true,
			silent_chdir = false,
			scope_chdir = 'global',
			datapath = vim.fn.stdpath 'data',
		}
	end,
}
