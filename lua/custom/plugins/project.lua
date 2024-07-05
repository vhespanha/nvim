return {
  'gnikdroy/projections.nvim',
  branch = 'pre_release',
  config = function()
    require('projections').setup {

      workspaces = { -- Default workspaces to search for
        { '~/projects', {} },
        { '~/.config', {} },
      },
      -- patterns = { ".git", ".svn", ".hg" },      -- Default patterns to use if none were specified. These are NOT regexps.
      -- store_hooks = { pre = nil, post = nil },   -- pre and post hooks for store_session, callable | nil
      -- restore_hooks = { pre = nil, post = nil }, -- pre and post hooks for restore_session, callable | nil
      -- workspaces_file = "path/to/file",          -- Path to workspaces json file
      -- sessions_directory = "path/to/dir",        -- Directory where sessions are stored
    }

    require('telescope').load_extension 'projections'
    vim.keymap.set('n', '<leader>sp', function()
      require('telescope').extensions.projections.projections(require('telescope.themes').get_dropdown {})
    end)

    -- Autostore session on VimExit
    local Session = require 'projections.session'
    vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
      callback = function()
        local cwd = vim.loop.cwd()
        if cwd then
          Session.store(cwd)
        else
        end
      end,
    })

    -- Switch to project if vim was started in a project dir
    local switcher = require 'projections.switcher'
    vim.api.nvim_create_autocmd({ 'VimEnter' }, {
      callback = function()
        if vim.fn.argc() == 0 then
          local cwd = vim.loop.cwd()
          if cwd then
            switcher.switch(cwd)
          else
          end
        end
      end,
    })
  end,
}
