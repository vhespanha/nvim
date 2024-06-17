return {
  'ahmedkhalf/project.nvim',
  config = function()
    -- Load the telescope extension for projects
    require('telescope').load_extension 'projects'

    -- Set up project.nvim
    require('project_nvim').setup {
      manual_mode = false,
      show_hidden = true,
      silent_chdir = false,
      mappings = {},
    }

    -- Set up a key mapping to open the project picker
    vim.keymap.set('n', '<leader>sp', function()
      require('telescope').extensions.projects.projects(require('telescope.themes').get_dropdown {})
    end, { desc = 'Project Picker' })
  end,
}
